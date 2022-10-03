// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadedState extends PostsState {
  final List<Post> posts;
  const PostsLoadedState({
    required this.posts,
  });
  @override
  List<Object> get props => [posts];
}

class PostsErorState extends PostsState {
  final String errorMessage;

  const PostsErorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
