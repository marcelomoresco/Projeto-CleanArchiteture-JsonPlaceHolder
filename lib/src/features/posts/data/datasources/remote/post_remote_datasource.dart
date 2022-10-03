import 'package:dartz/dartz.dart';

import '../../models/post_model.dart';

abstract class IPostRemoteDatasource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> addPost(PostModel postModel);
}
