// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'crud_post_bloc.dart';

abstract class CrudPostState extends Equatable {
  const CrudPostState();

  @override
  List<Object> get props => [];
}

class CrudPostInitial extends CrudPostState {}

class CrudPostLoadingState extends CrudPostState {}

class CrudPostLoadedState extends CrudPostState {
  final String message;

  const CrudPostLoadedState({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

class CrudPostErrorState extends CrudPostState {
  final String errorMessage;

  const CrudPostErrorState({
    required this.errorMessage,
  });

  @override
  List<Object> get props => [errorMessage];
}
