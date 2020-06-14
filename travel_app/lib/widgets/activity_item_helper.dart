import 'package:flutter/material.dart';
import 'package:travelapp/models/activity_model.dart';
import 'package:travelapp/models/destination_model.dart';

class ActivityItemViewHelper {
  buildActivityList(Destination destination) => Expanded(
        child: ListView.builder(
          itemCount: destination.activities.length,
          itemBuilder: (BuildContext context, int index) =>
              _activityItem(context, activities[index]),
        ),
      );

  _activityItem(BuildContext context, Activity activity) => Stack(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(40, 4, 20, 4),
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(96, 16, 16, 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _activityTitleAndPrice(context, activity),
                  _activityType(context, activity),
                  SizedBox(height: 8),
                  _ratingStar(context, activity.rating),
                  SizedBox(height: 16),
                  _activityStartTimes(context, activity),
                ],
              ),
            ),
          ),
          _activityImage(context, activity),
        ],
      );

  _activityTitleAndPrice(BuildContext context, Activity activity) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 132,
            child: Text(
              activity.name,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          Column(
            children: [
              Text(
                "\$ ${activity.price}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text("per pax",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.grey))
            ],
          ),
        ],
      );

  _activityType(BuildContext context, Activity activity) => Text(activity.type,
      style:
          Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.grey));

  _ratingStar(BuildContext context, int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    return Text(stars.trim(), style: Theme.of(context).textTheme.bodyText2);
  }

  _activityStartTimes(BuildContext context, Activity activity) => Row(
        children: [
          Container(
            width: 72,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(activity.startTimes[0],
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ),
          SizedBox(width: 8),
          Container(
            width: 72,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(activity.startTimes[1],
                  style: Theme.of(context).textTheme.bodyText2),
            ),
          ),
        ],
      );

  _activityImage(BuildContext context, Activity activity) => Positioned(
        left: 12,
        bottom: 16,
        top: 16,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image(
            width: 112,
            image: AssetImage(activity.imageUrl),
            fit: BoxFit.cover,
          ),
        ),
      );
}
