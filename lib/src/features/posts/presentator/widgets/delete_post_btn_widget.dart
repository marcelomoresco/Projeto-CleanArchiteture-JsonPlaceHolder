import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/blocs/crud_posts/crud_post_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/widgets/loading_widget.dart';

import '../../../../core/utils/snackbar_message.dart';
import '../views/home/posts_page.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;
  const DeletePostBtnWidget({
    Key? key,
    required this.postId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, postId),
      icon: const Icon(Icons.delete_outline),
      label: const Text("Deletar"),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<CrudPostBloc, CrudPostState>(
            listener: (context, state) {
              if (state is CrudPostLoadedState) {
                SnackBarMessage().showSucessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const PostsPage(),
                    ),
                    (route) => false);
              } else if (state is CrudPostErrorState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.errorMessage, context: context);
              }
            },
            builder: (context, state) {
              if (state is CrudPostLoadingState) {
                return const AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return AlertDialog(
                title: const Text("Tem certeza que quer deletar?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      "Não",
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<CrudPostBloc>().add(
                            DeletePostEvent(postId: postId),
                          );
                    },
                    child: const Text("Sim"),
                  ),
                ],
              );
            },
          );
        });
  }
}
