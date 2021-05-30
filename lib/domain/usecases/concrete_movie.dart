import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/domain/entities/movie.dart';
import 'package:flutter_clean_architecture/domain/repository/movie_repository.dart';

class ConcreteMovie implements UseCase<List<Movie>, NoParams> {
  final MovieRepository repository;

  ConcreteMovie({@required this.repository});

  @override
  Future<Either<Failure, List<Movie>>> call(NoParams params) async {
    return await repository.getMovie();
  }
}
