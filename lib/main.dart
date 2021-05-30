import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/modules/movies/movies_screen.dart';
import 'package:flutter_clean_architecture/di/injection_container.dart'
    as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MoviesScreen(),
    );
  }
}
