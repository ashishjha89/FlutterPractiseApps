import 'package:flutter/material.dart';

gardenEmptyContainer(BuildContext context, TabController tabController) =>
    Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Your garden is empty',
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 8),
          GestureDetector(
            onTap: () => tabController.animateTo(1),
            child: Container(
              width: 120,
              height: 50,
              child: Center(
                child: Text(
                  'ADD PLANT',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16))),
            ),
          )
        ],
      ),
    );
