import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_weather_app/data/data%20sources/remote_data_source.dart';
import 'package:flutter_weather_app/data/exception.dart';
import 'package:flutter_weather_app/data/failure.dart';
import 'package:flutter_weather_app/domain/entities/weather.dart';
import 'package:flutter_weather_app/domain/reposetories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final RemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather(String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
