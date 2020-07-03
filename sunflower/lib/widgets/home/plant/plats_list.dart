import 'package:flutter/material.dart';
import 'package:sunflower/model/plant.dart';
import 'package:sunflower/repo/plants_repo.dart';
import 'package:sunflower/screens/description_screen.dart';
import 'package:sunflower/widgets/home/plant/plant_card_item.dart';

plantsContainer(BuildContext context, List<Plant> plants,
    List<Plant> gardenPlants, LoadPlantsRepo repo) {
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
            plants.length,
            (index) => GestureDetector(
                  onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DescriptionScreen(
                                  isInGarden:
                                      gardenPlants.contains(plants[index]),
                                  plant: plants[index],
                                  repo: repo,
                                )))
                  },
                  child: PlantCardItem(
                    plant: plants[index],
                    itemWidth: itemWidth,
                    imageHeight: imageHeight
                  ),
                ))),
  );
}
