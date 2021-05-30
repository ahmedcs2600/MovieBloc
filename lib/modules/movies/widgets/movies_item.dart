import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/domain/entities/movie.dart';

class MoviesItem extends StatelessWidget {


  final Movie item;

  MoviesItem({@required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.title,style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(height: 10.0),
            Text(item.overview),
            SizedBox(height : 10.0)
          ],
        ),
      ),
    );
  }
}