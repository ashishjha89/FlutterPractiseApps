import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/LakeCampGround.dart';
import 'package:my_app/PavlovaCake.dart';

import 'LogoWidget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _buildAppTheme(context),
      home: MyBottomNavigationWidget(),
    );
  }

  _buildAppTheme(BuildContext context) => ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: _buildTextTheme(context),
      );

  _buildTextTheme(BuildContext context) => Theme.of(context)
      .textTheme
      .apply(bodyColor: Colors.black, displayColor: Colors.black);
}

class MyBottomNavigationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyBottomNavigationWidgetState();
}

class MyBottomNavigationWidgetState extends State<MyBottomNavigationWidget> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = [
    PavlovaCake(),
    LakeCampGround(),
    LogoApp()
  ];

  final List<String> appBarTitles = [
    'Pavlova Cake',
    'Lake Campground',
    "Flutter Logo"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitles[_selectedIndex]),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.cake), title: new Text("Cake")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.card_travel), title: new Text("Travel")),
          BottomNavigationBarItem(
              icon: new Icon(Icons.apps), title: new Text("Flutter")),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
