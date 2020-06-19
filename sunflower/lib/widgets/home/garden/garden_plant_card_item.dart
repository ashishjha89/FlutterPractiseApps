import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sunflower/model/plant.dart';

class GardenPlantCardItem extends StatelessWidget {
  final Plant plant;

  final int itemWidth;
  final int imageHeight;

  const GardenPlantCardItem({this.plant, this.itemWidth, this.imageHeight});

  @override
  Widget build(BuildContext context) => Hero(
        tag: plant.plantId,
        child: Column(
          children: <Widget>[
            Container(
              width: itemWidth.toDouble(),
              decoration: _cardDecoration(),
              child: Column(
                children: [_cardImage(), _cardDescription(context)],
              ),
            ),
          ],
        ),
      );

  _cardDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0.0, 2.0),
            blurRadius: 6.0,
          ),
        ],
      );

  _cardImage() => ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
        child: CachedNetworkImage(
          width: itemWidth.toDouble(),
          height: imageHeight.toDouble(),
          imageUrl: plant.imageUrl,
          fit: BoxFit.cover,
        ),
      );

  _cardDescription(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 16),
          Center(
              child: Text(
            plant.name,
            style: Theme.of(context).textTheme.bodyText2,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          SizedBox(height: 16),
        ],
      );
}
