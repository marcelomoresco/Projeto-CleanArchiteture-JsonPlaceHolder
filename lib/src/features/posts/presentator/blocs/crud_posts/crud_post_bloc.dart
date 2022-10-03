// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:post_project_clean_arch/src/core/strings/messages.dart';

import 'package:post_project_clean_arch/src/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/usecases/update_post_usecase.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/post_entity.dart';

part 'crud_post_event.dart';
part 'crud_post_state.dart';

class CrudPostBloc extends Bloc<CrudPostEvent, CrudPostState> {
  final AddPostUsecase addPostUsecase;
  final UpdatePostUsecase updatePostUsecase;
  final DeletePostUsecase deletePostUsecase;

  CrudPostBloc({
    required this.addPostUsecase,
    required this.updatePostUsecase,
    required this.deletePostUsecase,
  }) : super(CrudPostInitial()) {
    on<AddPostEvent>(_addPostEvent);
    on<UpdatePostEvent>(_updatePostEvent);
    on<DeletePostEvent>(_deletePostEvent);
  }

  void _addPostEvent(AddPostEvent event, Emitter<CrudPostState> emit) async {
    emit(CrudPostLoadingState());

    final failureOrDoneMessage = await addPostUsecase(event.post);

    emit(_eitherDoneMessageOrErrorState(
        failureOrDoneMessage, ADD_SUCESS_MESSAGE));
  }

  void _updatePostEvent(
      UpdatePostEvent event, Emitter<CrudPostState> emit) async {
    emit(CrudPostLoadingState());

    final failureOrDoneMessage = await updatePostUsecase(event.post);

    emit(_eitherDoneMessageOrErrorState(
        failureOrDoneMessage, UPDATE_SUCESS_MESSAGE));
  }

  void _deletePostEvent(
      DeletePostEvent event, Emitter<CrudPostState> emit) async {
    emit(CrudPostLoadingState());

    final failureOrDoneMessage = await deletePostUsecase(event.postId);

    emit(_eitherDoneMessageOrErrorState(
        failureOrDoneMessage, DELETE_SUCESS_MESSAGE));
  }

  CrudPostState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) =>
          CrudPostErrorState(errorMessage: _mapFailureToMessage(failure)),
      (_) => CrudPostLoadedState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Erro Inesperado, Por favor tente novamente mais tarde!";
    }
  }
}
