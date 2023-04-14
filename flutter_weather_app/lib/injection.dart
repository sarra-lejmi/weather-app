import 'package:flutter_weather_app/data/data%20sources/remote_data_source.dart';
import 'package:flutter_weather_app/data/reposetories/weather_repository_impl.dart';
import 'package:flutter_weather_app/domain/reposetories/weather_repository.dart';
import 'package:flutter_weather_app/domain/usecases/get_current_weather.dart';
import 'package:flutter_weather_app/presentation/bloc/weather_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  locator.registerFactory(() => WeatherBloc(locator()));

  locator.registerLazySingleton(() => GetCurrentWeather(locator()));

  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton(() => http.Client());
}
