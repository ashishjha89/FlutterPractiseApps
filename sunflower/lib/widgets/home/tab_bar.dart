import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

tabBar(BuildContext context, int selectedIndex, TabController tabController) =>
    TabBar(
      controller: tabController,
      indicatorColor: Colors.yellow,
      tabs: [
        Tab(
            icon: selectedIndex == 0
                ? _tab(
                    context, 'assets/images/my_garden_active.svg', 'MY GARDEN')
                : _tab(context, 'assets/images/my_garden_inactive.svg',
                    'MY GARDEN')),
        Tab(
            icon: selectedIndex == 1
                ? _tab(context, 'assets/images/plant_list_active.svg',
                    'PLANT LIST')
                : _tab(context, 'assets/images/plant_list_inactive.svg',
                    'PLANT LIST')),
      ],
    );

_tab(BuildContext context, String assetName, String label) => Column(
      children: <Widget>[
        SvgPicture.asset(
          assetName,
          width: 24,
          height: 24,
        ),
        SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(height: 2),
      ],
    );
