part of 'movies_bloc.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object> get props => [];
}

class MoviesInitial extends MoviesState {}

class Error extends MoviesState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

class Loaded extends MoviesState {
  final List<Movie> movies;

  Loaded({@required this.movies});

  @override
  List<Object> get props => [movies];
}

class Loading extends MoviesState {}
