import 'package:flutter/material.dart';
import 'package:sunflower/model/plant.dart';
import 'package:sunflower/model/plant_state.dart';
import 'package:sunflower/repo/plants_repo.dart';
import 'package:sunflower/widgets/home/garden/garden_empty.dart';
import 'package:sunflower/widgets/home/garden/garden_plant_list.dart';
import 'package:sunflower/widgets/home/plant/plats_list.dart';
import 'package:sunflower/widgets/home/tab_bar.dart';

class HomeScreen extends StatefulWidget {
  final LoadPlantsRepo repo;

  const HomeScreen({@required this.repo});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  PlantState plantState = PlantState.loading();
  PlantState myGardenState = PlantState.loading();
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    widget.repo.getPlants(context).then((loadedPlants) {
      for (Plant plant in loadedPlants) {
        precacheImage(new NetworkImage(plant.imageUrl), context);
      }
      setState(() {
        plantState = PlantState.loadingComplete(plants: loadedPlants);
      });
    }).catchError((err) {
      setState(() {
        plantState = PlantState.loadingComplete();
      });
    });

    widget.repo.getMyGardenPlants().then((loadedPlants) {
      for (Plant plant in loadedPlants) {
        precacheImage(new NetworkImage(plant.imageUrl), context);
      }
      setState(() {
        myGardenState = PlantState.loadingComplete(plants: loadedPlants);
      });
    }).catchError((err) {
      setState(() {
        myGardenState = PlantState.loadingComplete();
      });
    });
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(appBar: _appBar(), body: _tabBarView());

  _appBar() => AppBar(
        title: Center(
            child: Text(
          "Sunflower",
          style: Theme.of(context)
              .textTheme
              .headline5
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        )),
        elevation: 0.0,
        bottom: tabBar(context, _tabController.index, _tabController),
      );

  _tabBarView() => TabBarView(
      controller: _tabController,
      children: [_myGardensContainer(), _plantsContainer()]);

  _myGardensContainer() =>
      myGardenState.isLoading || myGardenState.plants.isEmpty
          ? gardenEmptyContainer(context, _tabController)
          : _myGardensList();

  _plantsContainer() => plantState.isLoading || plantState.plants.isEmpty
      ? _loading()
      : _plantsList();

  _loading() => Center(child: CircularProgressIndicator(key: Key('Loading')));

  _plantsList() => plantsContainer(
      context, plantState.plants, myGardenState.plants, widget.repo);

  _myGardensList() =>
      gardenPlantsContainer(context, myGardenState.plants, widget.repo);
}
