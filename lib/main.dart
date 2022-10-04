// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/blocs/crud_posts/crud_post_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/blocs/posts_bloc/posts_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/views/home/posts_page.dart';
import 'src/core/injector/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider<CrudPostBloc>(
          create: (_) => di.sl<CrudPostBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: const PostsPage(),
      ),
    );
  }
}
