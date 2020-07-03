import 'package:sunflower/model/plant.dart';

class PlantState {
  final bool isLoading;
  final List<Plant> plants;

  PlantState({
    this.isLoading = false,
    this.plants = const [],
  });

  factory PlantState.loading() => PlantState(isLoading: true);

  factory PlantState.loadingComplete({List<Plant> plants = const []}) =>
      PlantState(isLoading: false, plants: plants);
}
