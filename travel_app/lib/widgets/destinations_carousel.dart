import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travelapp/models/destination_model.dart';
import 'package:travelapp/screens/destination_screen.dart';

class DestinationsCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [_topRow(context), _carouselList()],
    );
  }

  _topRow(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 32, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [_title(context), _seeAllLabel(context)],
        ),
      );

  _carouselList() => Container(
        height: 328,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: destinations.length,
            itemBuilder: (BuildContext context, int index) {
              final destination = destinations[index];
              return GestureDetector(
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              DestinationScreen(destination: destination)))
                },
                child: _carouselItem(context, destination),
              );
            }),
      );

  _title(BuildContext context) => Text(
        'Top Destinations',
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontWeight: FontWeight.bold),
      );

  _seeAllLabel(BuildContext context) => Text(
        "See all",
        style: Theme.of(context).textTheme.subtitle1.copyWith(
            color: Theme.of(context).primaryColor, fontWeight: FontWeight.w600),
      );

  _carouselItem(BuildContext context, Destination destination) => Stack(
        children: [
          Container(
            width: 240,
          ),
          Positioned(
            bottom: 8,
            child: Container(
              width: 240,
              child: _carouselItemDescription(context, destination),
            ),
          ),
          Positioned(
            left: 16,
            child: Container(
              child: _carouselItemPortrait(context, destination),
            ),
          ),
        ],
      );

  _carouselItemDescription(BuildContext context, Destination destination) =>
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 62),
              Text(
                "${destination.activities.length} activities",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                destination.description,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.blueGrey[500]),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  _carouselItemPortrait(BuildContext context, Destination destination) =>
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Hero(
          tag: destination.imageUrl,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image(
                  width: 208,
                  height: 208,
                  image: AssetImage(destination.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 208,
                  height: 208,
                  color: Colors.black45,
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: _carouselItemCityDesc(context, destination),
              ),
            ],
          ),
        ),
      );

  _carouselItemCityDesc(BuildContext context, Destination destination) =>
      Container(
        alignment: Alignment.bottomLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              destination.city,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  FontAwesomeIcons.locationArrow,
                  size: 10.0,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text(
                  destination.country,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white70),
                )
              ],
            )
          ],
        ),
      );
}
