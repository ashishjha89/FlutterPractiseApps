import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sunflower/repo/plants_repo.dart';
import 'package:sunflower/screens/home_screen.dart';

import 'model/DatabaseHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sunflower',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF49bb79),
        primaryColorDark: Color(0xFF005d2b),
        accentColor: Color(0xFF005d2b),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreen(repo: LoadPlantsRepo(dbHelper: DatabaseHelper.instance)),
    );
  }
}
