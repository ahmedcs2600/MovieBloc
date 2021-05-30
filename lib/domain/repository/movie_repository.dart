import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<Either<Failure,List<Movie>>> getMovie();
}