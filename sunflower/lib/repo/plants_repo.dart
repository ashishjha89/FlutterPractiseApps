import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sunflower/model/DatabaseHelper.dart';
import 'package:sunflower/model/plant.dart';

class LoadPlantsRepo {
  final DatabaseHelper dbHelper;

  const LoadPlantsRepo({@required this.dbHelper});

  Future<List<Plant>> getPlants(BuildContext context) async {
    assert(context != null);
    final json =
        DefaultAssetBundle.of(context).loadString('assets/data/plants.json');
    final data = jsonDecode(await json) as List;
    return data.map((plantJson) => Plant.fromJson(plantJson)).toList();
  }

  Future<List<Plant>> getMyGardenPlants() async {
    final allRows = await dbHelper.queryAllRows();
    return allRows.map((plantJson) => Plant.fromJson(plantJson)).toList();
  }

  Future<bool> insertPlantToGarden(Plant plant) async {
    final rowId = await dbHelper.insert(plant.toMap());
    return rowId >= 0;
  }

  Future<bool> deletePlantFromGarden(Plant plant) async {
    final rowId = await dbHelper.delete(plant.plantId);
    return rowId > 0;
  }
}
