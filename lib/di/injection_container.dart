import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_clean_architecture/core/network/network_info.dart';
import 'package:flutter_clean_architecture/data/datasource/local/movies_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasource/remote/movies_remote_data_source.dart';
import 'package:flutter_clean_architecture/data/repository/movies_repository_imp.dart';
import 'package:flutter_clean_architecture/domain/repository/movie_repository.dart';
import 'package:flutter_clean_architecture/domain/usecases/concrete_movie.dart';
import 'package:flutter_clean_architecture/modules/movies/bloc/movies_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => MoviesBloc(concreteMovie: sl()),
  );

  // Data Source
  sl.registerFactory<MoviesLocalDataSource>(
      () => MoviesLocalDataSourceImp(sharedPreferences: sl()));
  sl.registerFactory<MoviesRemoteDataSource>(
      () => MoviesRemoteDataSourceImp(client: sl()));

  sl.registerFactory<MovieRepository>(() => MovieRepositoryImp(
      moviesRemoteDataSource: sl(),
      networkInfo: sl(),
      moviesLocalDataSource: sl()));

  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImp(connectionChecker: sl()));

  sl.registerFactory(() => ConcreteMovie(repository: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
