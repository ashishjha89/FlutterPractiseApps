import 'package:flutter/material.dart';
import 'package:sunflower/model/plant.dart';
import 'package:sunflower/repo/plants_repo.dart';
import 'package:sunflower/screens/description_screen.dart';

import 'garden_plant_card_item.dart';

gardenPlantsContainer(
    BuildContext context, List<Plant> gardenPlants, LoadPlantsRepo repo) {
  final int itemWidth = 160;
  final screenWidth = MediaQuery.of(context).size.width;
  final double columnCount = (screenWidth / itemWidth);
  final int imageHeight = 128;
  final aspectRatio = 0.75;

  return Container(
    color: Theme.of(context).primaryColor,
    child: GridView.count(
        childAspectRatio: aspectRatio,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        crossAxisCount: columnCount.floor(),
        children: List.generate(
            gardenPlants.length,
            (index) => GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DescriptionScreen(
                                  isInGarden: true,
                                  plant: gardenPlants[index],
                                  repo: repo,
                                )))
                  },
                  child: GardenPlantCardItem(
                      plant: gardenPlants[index],
                      itemWidth: itemWidth,
                      imageHeight: imageHeight),
                ))),
  );
}
