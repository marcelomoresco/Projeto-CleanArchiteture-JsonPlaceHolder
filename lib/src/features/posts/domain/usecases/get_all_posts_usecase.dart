// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/repositories/post_repository.dart';

import '../../../../core/error/failures.dart';
import '../entities/post_entity.dart';

class GetAllPostsUsecase {
  final IPostRepository repository;

  GetAllPostsUsecase({
    required this.repository,
  });

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
