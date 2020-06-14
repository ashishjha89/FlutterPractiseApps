import 'package:flutter/material.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/widgets/activity_header_helper.dart';
import 'package:travelapp/widgets/activity_item_helper.dart';

class DestinationScreen extends StatefulWidget {
  final Destination destination;

  DestinationScreen({this.destination});

  @override
  State<StatefulWidget> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  final activityHeaderHelper = ActivityHeaderHelper();
  final activityItemViewHelper = ActivityItemViewHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
          activityHeaderHelper.buildHeader(context, widget.destination),
          activityItemViewHelper.buildActivityList(widget.destination),
        ]));
  }
}
