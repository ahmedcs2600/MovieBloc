import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MoviesLocalDataSource {
  Future<List<MovieModel>> getSavedMovies();

  Future<void> saveMovies(List<MovieModel> movies);
}

const CACHED_MOVIES = "CACHED_MOVIES";

class MoviesLocalDataSourceImp extends MoviesLocalDataSource {
  final SharedPreferences sharedPreferences;

  MoviesLocalDataSourceImp({@required this.sharedPreferences});

  @override
  Future<List<MovieModel>> getSavedMovies() {
    final data = sharedPreferences.getString(CACHED_MOVIES);
    if (data != null) {
      List<dynamic> list = json.decode(data);
      return Future.value(list.map((e) => MovieModel.fromJson(e)).toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveMovies(List<MovieModel> movies) async {
    await sharedPreferences.setString(
        CACHED_MOVIES, json.encode(movies.map((e) => e.toJson()).toList()));
  }
}
