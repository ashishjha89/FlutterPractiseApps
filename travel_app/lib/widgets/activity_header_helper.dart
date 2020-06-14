import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/models/destination_model.dart';

class ActivityHeaderHelper {

  buildHeader(BuildContext context, Destination destination) => Stack(
        children: [
          _cityHeader(context, destination),
          _topBar(context),
        ],
      );

  _cityHeader(BuildContext context, Destination destination) => Container(
        height: min(400, MediaQuery.of(context).size.width),
        decoration: _headerImageBoxDecoration(),
        child: _headerImage(context, destination),
      );

  _topBar(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_backButton(context), _topBarOptionButtons(context)],
        ),
      );

  _headerImageBoxDecoration() => BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(color: Colors.black26, offset: Offset(0, 2), blurRadius: 6)
        ],
      );

  _headerImage(BuildContext context, Destination destination) => Hero(
        tag: destination.imageUrl,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image(
                height: min(400, MediaQuery.of(context).size.width),
                image: AssetImage(destination.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Container(
                height: min(400, MediaQuery.of(context).size.width),
                color: Colors.black45,
              ),
            ),
            Positioned(
              left: 24,
              bottom: 24,
              child: _headerCityDesc(context, destination),
            ),
            Positioned(
              right: 24,
              bottom: 24,
              child: _headerLocationIcon(),
            ),
          ],
        ),
      );

  _backButton(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        iconSize: 32,
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      );

  _topBarOptionButtons(BuildContext context) => Row(
        children: [_searchButton(context), _sortButton(context)],
      );

  _searchButton(BuildContext context) => IconButton(
        icon: Icon(Icons.search),
        iconSize: 32,
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      );

  _sortButton(BuildContext context) => IconButton(
        icon: Icon(FontAwesomeIcons.sortAmountDown),
        iconSize: 26,
        color: Colors.black,
        onPressed: () => Navigator.pop(context),
      );

  _headerCityDesc(BuildContext context, Destination destination) => Container(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              destination.city,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white70),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.locationArrow,
                  size: 16.0,
                  color: Colors.white,
                ),
                SizedBox(width: 8),
                Text(
                  destination.country,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white70),
                )
              ],
            )
          ],
        ),
      );

  _headerLocationIcon() => Icon(
        Icons.location_on,
        color: Colors.white70,
        size: 24,
      );
}
