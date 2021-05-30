import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/di/injection_container.dart';
import 'package:flutter_clean_architecture/modules/movies/bloc/movies_bloc.dart';
import 'package:flutter_clean_architecture/modules/movies/widgets/movies_item.dart';

class MoviesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movies")),
      body: BlocProvider(
        create: (_) => sl<MoviesBloc>()..add(LoadMovies()),
        child: BlocBuilder<MoviesBloc,MoviesState>(
          builder: (context, state) {
            if(state is Loading){
              return CircularProgressIndicator();
            }

            if(state is Loaded){
              return ListView.builder(
                itemCount: state.movies.length,
                itemBuilder: (context, index) {
                  return MoviesItem(item: state.movies[index]);
                },
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}