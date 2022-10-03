import 'package:get_it/get_it.dart';
import 'package:post_project_clean_arch/src/core/network/network_info.dart';
import 'package:post_project_clean_arch/src/features/posts/data/datasources/local/post_local_datasource.dart';
import 'package:post_project_clean_arch/src/features/posts/data/datasources/local/post_local_datasource_implementation.dart';
import 'package:post_project_clean_arch/src/features/posts/data/datasources/remote/post_remote_datasource.dart';
import 'package:post_project_clean_arch/src/features/posts/data/datasources/remote/post_remote_datasource_implementation.dart';
import 'package:post_project_clean_arch/src/features/posts/data/repositories/post_repository_imp.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/repositories/post_repository.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/usecases/add_post_usecase.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/usecases/get_all_posts_usecase.dart';
import 'package:post_project_clean_arch/src/features/posts/domain/usecases/update_post_usecase.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/blocs/crud_posts/crud_post_bloc.dart';
import 'package:post_project_clean_arch/src/features/posts/presentator/blocs/posts_bloc/posts_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //features

  //bloc

  sl.registerFactory(() => PostsBloc(getAllPostsUsecase: sl()));
  sl.registerFactory(() => CrudPostBloc(
        addPostUsecase: sl(),
        updatePostUsecase: sl(),
        deletePostUsecase: sl(),
      ));

  //usecase

  sl.registerLazySingleton(() => GetAllPostsUsecase(repository: sl()));
  sl.registerLazySingleton(() => AddPostUsecase(repository: sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(repository: sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(repository: sl()));

  //repository

  sl.registerLazySingleton<IPostRepository>(
    () => PostRepositoryImp(
      remoteDatasource: sl(),
      localDatasource: sl(),
      networkInfo: sl(),
    ),
  );

  //datasources
  sl.registerLazySingleton<IPostRemoteDatasource>(
      () => PostRemoteDatasourceImplementation(client: sl()));
  sl.registerLazySingleton<IPostLocalDatasource>(
      () => PostLocalDatasourceImplementation(sharedPreferences: sl()));

  //core

  sl.registerFactory<INetworkInfo>(
      () => NetworkInfoImp(internetConnectionChecker: sl()));

  //external

  sl.registerLazySingleton(() => SharedPreferences.getInstance());
}
