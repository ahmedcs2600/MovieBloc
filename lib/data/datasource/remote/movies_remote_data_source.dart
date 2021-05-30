import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/error/exceptions.dart';
import 'package:flutter_clean_architecture/core/network/urls.dart';
import 'package:flutter_clean_architecture/data/models/movie_model.dart';
import 'package:flutter_clean_architecture/extensions/strings.dart';
import 'package:flutter_clean_architecture/global/app_constants.dart';
import 'package:http/http.dart' as http;

abstract class MoviesRemoteDataSource {
  Future<List<MovieModel>> getMovies();
}

class MoviesRemoteDataSourceImp implements MoviesRemoteDataSource {
  final http.Client client;

  MoviesRemoteDataSourceImp({@required this.client});

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await client
        .get("${URLS.popularMovie}?api_key=${AppConstants.api_key}".toUri);
    if (response.statusCode == 200) {
      List<dynamic> results = response.body.toJson["results"];
      return results.map((e) => MovieModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
