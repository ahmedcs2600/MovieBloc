import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/network/network_info.dart';
import 'package:flutter_clean_architecture/data/datasource/local/movies_local_data_source.dart';
import 'package:flutter_clean_architecture/data/datasource/remote/movies_remote_data_source.dart';
import 'package:flutter_clean_architecture/domain/entities/movie.dart';
import 'package:flutter_clean_architecture/domain/repository/movie_repository.dart';

class MovieRepositoryImp implements MovieRepository {
  MoviesLocalDataSource moviesLocalDataSource;
  MoviesRemoteDataSource moviesRemoteDataSource;
  NetworkInfo networkInfo;

  MovieRepositoryImp(
      {@required this.moviesRemoteDataSource,
      @required this.networkInfo,
      @required this.moviesLocalDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getMovie() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await moviesRemoteDataSource.getMovies();
        await moviesLocalDataSource.saveMovies(response);
        return Right(response);
      } on ServerFailure {
        return Left(ServerFailure());
      }
    } else {
      try {
        final movies = await moviesLocalDataSource.getSavedMovies();
        return Right(movies);
      } on CacheFailure {
        return Left(CacheFailure());
      }
    }
  }
}
