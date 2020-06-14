// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import 'unit.dart';

const _padding = EdgeInsets.all(16.0);
const _viewMargin = 16.0;
final _dropDownBorderColor = Colors.grey[400];
final _dropDownBoxColor = Colors.grey[50];
const _dropDownBoxVerticalPadding = 8.0;
const _arrowIconSize = 40.0;

/// [ConverterScreen] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
class ConverterScreen extends StatefulWidget {
  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterScreen] requires the color and units to not be null.
  const ConverterScreen({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  _ConverterScreenState createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  bool _showValidationError = false;
  Unit _fromValue;
  Unit _toValue;
  double _inputValue;
  String _convertedValue = '';
  List<DropdownMenuItem> _unitMenuItems;

  @override
  void initState() {
    super.initState();
    _createDropdownMenuItems();
    _setDefaults();
  }

  @override
  Widget build(BuildContext context) {
    final inputContainer = _buildContainer(context, isInput: true);
    final arrow = _buildArrow();
    final outputContainer = _buildContainer(context, isInput: false);

    final converter = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        inputContainer,
        arrow,
        outputContainer,
      ],
    );

    return Padding(
      padding: _padding,
      child: converter,
    );
  }

  _buildContainer(BuildContext context, {@required bool isInput}) => Padding(
        padding: _padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _createTextField(context, isInput),
            _createDropDown(context, isInput),
          ],
        ),
      );

  _buildArrow() => RotatedBox(
        quarterTurns: 1,
        child: Icon(
          Icons.compare_arrows,
          size: _arrowIconSize,
        ),
      );

  _createTextField(BuildContext context, bool isInput) =>
      isInput ? _buildInputTextField(context) : _buildOutputTextField(context);

  _createDropDown(BuildContext context, bool isInput) => _buildDropDown(
      context,
      isInput ? _fromValue : _toValue,
      isInput ? _updateFromConversion : _updateToConversion);

  _buildInputTextField(BuildContext context) => TextField(
        style: Theme.of(context).textTheme.headline4,
        keyboardType: TextInputType.number,
        onChanged: _updateInputValue,
        decoration: _buildInputDecoration(context, labelText: 'Input'),
      );

  _buildOutputTextField(BuildContext context) => InputDecorator(
        decoration: _buildInputDecoration(context, labelText: 'Output'),
        child: Text(
          _convertedValue,
          style: Theme.of(context).textTheme.headline4,
        ),
      );

  _buildInputDecoration(BuildContext context, {String labelText}) =>
      InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.headline4,
        errorText: _showValidationError ? 'Invalid number entered' : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
      );

  _buildDropDown(
          BuildContext context, Unit value, ValueChanged<dynamic> onChanged) =>
      Container(
        margin: EdgeInsets.only(top: _viewMargin),
        padding: EdgeInsets.symmetric(vertical: _dropDownBoxVerticalPadding),
        decoration: _buildDropDownBoxDecoration(),
        child: _buildDropDownButton(context, value, onChanged),
      );

  _buildDropDownButton(
          BuildContext context, Unit value, ValueChanged<dynamic> onChanged) =>
      Theme(
        // This sets the color of the [DropdownMenuItem]
        data: Theme.of(context).copyWith(
          canvasColor: _dropDownBoxColor,
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: value.name,
              style: Theme.of(context).textTheme.headline6,
              items: _unitMenuItems,
              onChanged: onChanged,
            ),
          ),
        ),
      );

  _buildDropDownBoxDecoration() => BoxDecoration(
        color: _dropDownBoxColor,
        border: Border.all(
          color: _dropDownBorderColor,
          width: 1.0,
        ),
      );

  void _createDropdownMenuItems() {
    var newItems = <DropdownMenuItem>[];
    for (var unit in widget.units) {
      newItems.add(_buildDropDownMenuItem(unit));
    }
    setState(() {
      _unitMenuItems = newItems;
    });
  }

  _buildDropDownMenuItem(Unit unit) => DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      );

  void _setDefaults() {
    setState(() {
      _fromValue = widget.units[0];
      _toValue = widget.units[1];
    });
  }

  void _updateConversion() {
    setState(() {
      _convertedValue =
          _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    });
  }

  void _updateInputValue(String input) {
    setState(() {
      if (input == null || input.isEmpty) {
        _convertedValue = '';
      } else {
        // Even though we are using the numerical keyboard, we still have to check
        // for non-numerical input such as '5..0' or '6 -3'
        try {
          final inputDouble = double.parse(input);
          _showValidationError = false;
          _inputValue = inputDouble;
          _updateConversion();
        } on Exception catch (e) {
          print('Error: $e');
          _showValidationError = true;
        }
      }
    });
  }

  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }

  Unit _getUnit(String unitName) {
    return widget.units.firstWhere(
      (Unit unit) => unit.name == unitName,
      orElse: null,
    );
  }

  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }
}
