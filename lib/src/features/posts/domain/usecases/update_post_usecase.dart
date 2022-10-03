import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

class UpdatePostUsecase {
  final IPostRepository repository;

  UpdatePostUsecase({
    required this.repository,
  });

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}
