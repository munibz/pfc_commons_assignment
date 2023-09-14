import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:pfc_assignment/data/repository/movie_repository.dart';
import 'package:pfc_assignment/features/moviedetail/bloc/movie_detail_bloc.dart';
import 'package:pfc_assignment/features/movielist/bloc/movie_list_bloc.dart';
import '../data/core/api_client.dart';
import '../data/sources/movie_remote_data_source.dart';

final getIT = GetIt.instance;

Future init() async {
  getIT.registerLazySingleton<Client>(() => Client());
  getIT.registerLazySingleton<ApiClient>(() => ApiClient(getIT.get<Client>()));
  getIT.registerSingletonAsync(
      () async => MovieRemoteDataSource(getIT.get<ApiClient>()));

  getIT.registerSingletonWithDependencies(
    () => MovieRepository(getIT.get<MovieRemoteDataSource>()),
    dependsOn: [MovieRemoteDataSource],
  );

  getIT.registerFactory(
      () => MovieListBloc(repository: getIT.get<MovieRepository>()));

  getIT.registerFactory(
      () => MovieDetailBloc(repository: getIT.get<MovieRepository>()));
}
