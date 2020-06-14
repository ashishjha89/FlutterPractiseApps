import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/widgets/destinations_carousel.dart';
import 'package:travelapp/widgets/hotels_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIconIndex = 0;
  int _currentTab = 0;

  final _icons = [
    FontAwesomeIcons.plane,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.walking,
    FontAwesomeIcons.biking,
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: [
              _title(context),
              _iconsRow(context),
              DestinationsCarousel(),
              HotelsCarousel()
            ],
          ),
        ),
        bottomNavigationBar: _bottomNavigationBar(),
      );

  _title(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 32, bottom: 32, right: 64),
        child: Text(
          "What you would like to find?",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  _iconsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:
          _icons.asMap().entries.map((e) => _icon(context, e.key)).toList(),
    );
  }

  Widget _icon(BuildContext context, int index) => GestureDetector(
        onTap: () {
          setState(() {
            _selectedIconIndex = index;
          });
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: index == _selectedIconIndex
                ? Theme.of(context).accentColor
                : Colors.grey[300],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            _icons[index],
            size: 25,
            color: index == _selectedIconIndex
                ? Theme.of(context).primaryColor
                : Colors.grey[500],
          ),
        ),
      );

  _bottomNavigationBar() => BottomNavigationBar(
          currentIndex: _currentTab,
          onTap: (int value) {
            setState(() {
              _currentTab = value;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 32,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.local_pizza,
                size: 32,
              ),
              title: SizedBox.shrink(),
            ),
            BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage('http://i.imgur.com/zL4Krbz.jpg'),
              ),
              title: SizedBox.shrink(),
            ),
          ]);
}
