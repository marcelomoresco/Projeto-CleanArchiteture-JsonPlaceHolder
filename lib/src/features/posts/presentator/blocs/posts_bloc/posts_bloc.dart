import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:post_project_clean_arch/src/core/strings/failures.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/usecases/get_all_posts_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/post_entity.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUsecase getAllPostsUsecase;

  PostsBloc({required this.getAllPostsUsecase}) : super(PostsInitial()) {
    on<GetAllPostsEvent>(_onGetAllPostEvent);
    on<RefreshPostEvent>(_onRefreshPostEvent);
  }

  void _onRefreshPostEvent(
      RefreshPostEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    final failureOrPosts = await getAllPostsUsecase();
    emit(_mapFailureOrPostsToState(failureOrPosts));
  }

  void _onGetAllPostEvent(
      GetAllPostsEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoadingState());
    final failureOrPosts = await getAllPostsUsecase();
    emit(_mapFailureOrPostsToState(failureOrPosts));
  }

  PostsState _mapFailureOrPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
      (failure) => PostsErorState(errorMessage: _mapFailureToMessage(failure)),
      (post) => PostsLoadedState(posts: post),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erro Inesperado, Por favor tente novamente mais tarde!";
    }
  }
}
