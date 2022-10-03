// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:post_project_clean_arch/src/core/error/exception.dart';

import 'package:post_project_clean_arch/src/core/error/failures.dart';
import 'package:post_project_clean_arch/src/core/network/network_info.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/entities/post_entity.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/repositories/post_repository.dart';

import '../datasources/local/post_local_datasource.dart';
import '../datasources/remote/post_remote_datasource.dart';
import '../models/post_model.dart';

typedef Future<Unit> DeleteOrUpdateOrAddPost();

class PostRepositoryImp implements IPostRepository {
  final IPostRemoteDatasource remoteDatasource;
  final IPostLocalDatasource localDatasource;
  final INetworkInfo networkInfo;

  PostRepositoryImp({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() {
      return remoteDatasource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() {
      return remoteDatasource.deletePost(postId);
    });
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDatasource.getAllPosts();
        localDatasource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDatasource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );
    return await _getMessage(() {
      return remoteDatasource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
    DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
