import 'package:dartz/dartz.dart';

import '../../models/post_model.dart';

abstract class IPostLocalDatasource {
  Future<List<PostModel>> getCachedPosts();
  Future<Unit> cachePosts(List<PostModel> postModels);
}
