// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:post_project_clean_arch/src/core/error/exception.dart';

import 'package:post_project_clean_arch/src/features/posts/data/datasources/remote/post_remote_datasource.dart';
import 'package:post_project_clean_arch/src/features/posts/data/models/post_model.dart';

const BASE_URL = "https://jsonplaceholder.typicode.com";

class PostRemoteDatasourceImplementation implements IPostRemoteDatasource {
  final http.Client client;
  PostRemoteDatasourceImplementation({
    required this.client,
  });

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.post(Uri.parse(BASE_URL + "/posts/"), body: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse(BASE_URL + "/posts/${postId.toString()}"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(BASE_URL + "/posts/"),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List json = jsonDecode(response.body) as List;
      final List<PostModel> postModels = json
          .map<PostModel>((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();

      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final postId = postModel.id.toString();
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response = await client.patch(
      Uri.parse(BASE_URL + "/posts/$postId"),
      body: body,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
