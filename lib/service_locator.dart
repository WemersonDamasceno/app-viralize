import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:viralize/data/datasource/post_local_datasource.dart';
import 'package:viralize/data/datasource/post_remote_datasource.dart';
import 'package:viralize/data/repository/post_repository_impl.dart';
import 'package:viralize/domain/repository/post_repository.dart';
import 'package:viralize/presentation/home/bloc/post_bloc.dart';

import '../domain/usecases/add_post_usecase.dart';
import '../domain/usecases/get_posts_usecase.dart';

final sl = GetIt.instance;

void setupLocator() {
  // Datasources
  sl.registerLazySingleton(() => PostRemoteDataSource(http.Client()));
  sl.registerLazySingleton(() => PostLocalDataSource());

  // Repositório
  sl.registerLazySingleton<PostRepository>(
    () => PostRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Casos de Uso
  sl.registerLazySingleton(() => GetPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));

  // Bloc
  sl.registerFactory(() => PostBloc(
        getPostsUseCase: sl(),
        addPostUseCase: sl(),
      ));
}
