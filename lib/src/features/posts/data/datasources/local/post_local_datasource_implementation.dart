// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:post_project_clean_arch/src/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:post_project_clean_arch/src/features/posts/data/datasources/local/post_local_datasource.dart';
import 'package:post_project_clean_arch/src/features/posts/data/models/post_model.dart';

const CACHED_POSTS = "CACHED_POSTS";

class PostLocalDatasourceImplementation implements IPostLocalDatasource {
  final SharedPreferences sharedPreferences;

  PostLocalDatasourceImplementation({
    required this.sharedPreferences,
  });

  @override
  Future<Unit> cachePosts(List<PostModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();

    sharedPreferences.setString(CACHED_POSTS, jsonEncode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);

    if (jsonString != null) {
      List decodeJson = json.decode(jsonString);

      List<PostModel> jsonToPostModels = decodeJson
          .map<PostModel>((postModel) => PostModel.fromJson(postModel))
          .toList();

      return Future.value(jsonToPostModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
