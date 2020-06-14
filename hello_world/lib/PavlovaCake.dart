import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PavlovaCake extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isWideScreen = MediaQuery.of(context).size.width > 720;
    if (isWideScreen) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildCakeDescriptionContainer(context),
          ),
          Expanded(
            child: _buildCakeImageContainer(context),
          ),
        ],
      );
    } else {
      return ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCakeImageContainer(context),
              _buildCakeDescriptionContainer(context),
            ],
          ),
        ],
      );
    }
  }

  _buildCakeDescriptionContainer(BuildContext context) {
    final title = _buildTitleText(context);
    final description = _buildDescriptionText(context);
    final rating = _buildRating(context);
    final iconList = _buildIconList(context);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [title, description, rating, iconList],
        ),
      ),
    );
  }

  _buildCakeImageContainer(BuildContext context) => Image.asset(
        "assets/icons/pavlova_cake.jpg",
        fit: BoxFit.cover,
      );

  _buildTitleText(BuildContext context) => Text(
        "Strawberry Pavlova",
        style: Theme.of(context).textTheme.headline5,
      );

  _buildDescriptionText(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(
          "Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova. "
          "It is a meringue dessert with a crisp crust and soft, light inside, usually "
          "topped with fruit and whipped cream.",
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );

  _buildRating(BuildContext context) {
    final ratingStar = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.green[500]),
        Icon(Icons.star, color: Colors.black),
        Icon(Icons.star, color: Colors.black),
      ],
    );

    final ratingText = Text(
      "170 Reviews",
      style: Theme.of(context).textTheme.headline6,
    );

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [ratingStar, ratingText],
      ),
    );
  }

  _buildIconList(BuildContext context) => DefaultTextStyle.merge(
        style: Theme.of(context).textTheme.subtitle2,
        child: Container(
          padding: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.kitchen, color: Colors.green[500]),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('PREP:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('25 min'),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.timer, color: Colors.green[500]),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('COOK:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('1 hr'),
                  ),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.restaurant, color: Colors.green[500]),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('FEEDS:'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('4-6'),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
