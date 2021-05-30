import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:flutter_clean_architecture/core/usecases/usecase.dart';
import 'package:flutter_clean_architecture/domain/entities/movie.dart';
import 'package:flutter_clean_architecture/domain/usecases/concrete_movie.dart';
import 'package:flutter_clean_architecture/global/app_constants.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  ConcreteMovie concreteMovie;

  MoviesBloc({@required this.concreteMovie}) : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if (event is LoadMovies) {
      yield Loading();
      final failureOrTrivia =
      await concreteMovie(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrTrivia);
    }
  }

  Stream<MoviesState> _eitherLoadedOrErrorState(
    Either<Failure, List<Movie>> failureOrMovies,
  ) async* {
    yield failureOrMovies.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (movies) => Loaded(movies: movies),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppConstants.SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return AppConstants.CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
