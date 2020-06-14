// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// To keep your imports tidy, follow the ordering guidelines at
// https://www.dartlang.org/guides/language/effective-dart/style#ordering
import 'package:flutter/material.dart';
// @required is defined in the meta.dart package
import 'package:meta/meta.dart';

import 'converter_route.dart';
import 'unit.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

/// A custom [Category] widget.
///
/// The widget is composed on an [Icon] and [Text]. Tapping on the widget shows
/// a colored [InkWell] animation.
class Category extends StatelessWidget {
  final String name;
  final ColorSwatch color;
  final IconData iconLocation;
  final List<Unit> units;

  final _itemPadding = 8.0;
  final _iconSize = 60.0;
  final _iconPadding = 16.0;

  /// Creates a [Category].
  ///
  /// A [Category] saves the name of the Category (e.g. 'Length'), its color for
  /// the UI, and the icon that represents it (e.g. a ruler).
  // While the @required checks for whether a named parameter is passed in,
  // it doesn't check whether the object passed in is null. We check that
  // in the assert statement.
  const Category({
    Key key,
    @required this.name,
    @required this.color,
    @required this.iconLocation,
    @required this.units,
  })  : assert(name != null),
        assert(color != null),
        assert(iconLocation != null),
        assert(units != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: _rowHeight,
        child: InkWell(
          borderRadius: _borderRadius,
          highlightColor: color['highlight'],
          splashColor: color['splash'],
          onTap: () => _navigateToConverter(context),
          child: Padding(
            padding: EdgeInsets.all(_itemPadding),
            child: _buildChildRow(context),
          ),
        ),
      ),
    );
  }

  _buildChildRow(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Padding(
        padding: EdgeInsets.all(_iconPadding),
        child: Icon(
          iconLocation,
          size: _iconSize,
        ),
      ),
      Center(
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    ],
  );

  /// Navigates to the [ConverterScreen].
  void _navigateToConverter(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<Null>(
      builder: (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            title: Text(
              name,
              style: Theme.of(context).textTheme.headline4,
            ),
            centerTitle: true,
            backgroundColor: color,
          ),
          body: ConverterScreen(
            color: color,
            units: units,
          ),
          // This prevents the attempt to resize the screen when the keyboard is opened
          resizeToAvoidBottomPadding: false,
        );
      },
    ));
  }

}
