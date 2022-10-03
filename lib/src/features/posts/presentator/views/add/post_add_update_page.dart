// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:post_project_clean_arch/src/core/utils/snackbar_message.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/blocs/crud_posts/crud_post_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/views/home/posts_page.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/widgets/error_message_widget.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/widgets/loading_widget.dart';

import '../../../domain/entities/post_entity.dart';
import '../../widgets/form_widget.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdate;
  const PostAddUpdatePage({
    Key? key,
    this.post,
    required this.isUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? "Editar Post" : "Adicionar Post"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocConsumer<CrudPostBloc, CrudPostState>(
              builder: (context, state) {
            if (state is CrudPostLoadingState) {
              return const LoadingWidget();
            } else if (state is CrudPostErrorState) {
              return ErrorMessage(message: state.errorMessage);
            } else {
              return FormWidget(
                  isUpdate: isUpdate, post: isUpdate ? post : null);
            }
          }, listener: (context, state) {
            if (state is CrudPostLoadedState) {
              SnackBarMessage()
                  .showSucessSnackBar(message: state.message, context: context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => const PostsPage(),
                  ),
                  (route) => false);
            } else if (state is CrudPostErrorState) {
              SnackBarMessage().showErrorSnackBar(
                  message: state.errorMessage, context: context);
            }
          }),
        ),
      ),
    );
  }
}
