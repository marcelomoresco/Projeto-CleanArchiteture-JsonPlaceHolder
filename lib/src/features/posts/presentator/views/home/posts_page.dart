import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/blocs/posts_bloc/posts_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/views/add/post_add_update_page.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/widgets/error_message_widget.dart';

import '../../widgets/loading_widget.dart';
import '../../widgets/posts_list_widget.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Posts da API"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const PostAddUpdatePage(isUpdate: false)));
        },
        child: const Icon(Icons.add_circle_outline),
      ),
    );
  }

  Widget _buildBody() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoadingState) {
              return const LoadingWidget();
            } else if (state is PostsLoadedState) {
              return RefreshIndicator(
                  onRefresh: () async =>
                      context.read<PostsBloc>().add(RefreshPostEvent()),
                  child: PostListWidget(posts: state.posts));
            } else if (state is PostsErorState) {
              return ErrorMessage(message: state.errorMessage);
            } else {
              return const LoadingWidget();
            }
          },
        ));
  }
}
