import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LakeCampGround extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView(
        children: [
          _buildLakeImage(),
          _buildTitleSection(context),
          _buildButtonSection(context),
          _buildDescription(context)
        ],
      );

  _buildLakeImage() => Image.asset(
        "assets/icons/lake.png",
        height: 240,
        width: double.infinity,
        fit: BoxFit.cover,
      );

  _buildTitleSection(BuildContext context) => Container(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Oeschinen Lake Campground',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, left: 2),
                    child: Text(
                      "Kandersteg, Switzerland",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.star,
              color: Colors.red[500],
            ),
            Padding(
                padding: EdgeInsets.only(left: 2),
                child:
                    Text('41', style: Theme.of(context).textTheme.bodyText1)),
          ],
        ),
      );

  _buildButtonSection(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(context, color, Icons.call, 'CALL'),
          _buildButtonColumn(context, color, Icons.near_me, 'ROUTE'),
          _buildButtonColumn(context, color, Icons.share, 'SHARE'),
        ],
      ),
    );
  }

  _buildButtonColumn(
          BuildContext context, Color color, IconData icon, String label) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyText1.copyWith(color: color),
            ),
          )
        ],
      );

  _buildDescription(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          style: Theme.of(context).textTheme.subtitle1,
        ),
      );
}
