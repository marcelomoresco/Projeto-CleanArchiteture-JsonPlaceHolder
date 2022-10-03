import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class DeletePostUsecase {
  final IPostRepository repository;

  DeletePostUsecase({
    required this.repository,
  });

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
