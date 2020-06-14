import 'package:flutter/material.dart';
import 'package:travelapp/models/hotel_model.dart';

class HotelsCarousel extends StatelessWidget {
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
        height: 320,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hotels.length,
            itemBuilder: (BuildContext context, int index) {
              final hotel = hotels[index];
              return GestureDetector(
                //onTap: () => {},
                child: _carouselItem(context, hotel),
              );
            }),
      );

  _title(BuildContext context) => Text(
        'Exclusive Hotels',
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

  _carouselItem(BuildContext context, Hotel hotel) => Stack(
        children: [
          Container(
            width: 280,
          ),
          Positioned(
            bottom: 8,
            child: Container(
              width: 280,
              child: _carouselItemDescription(context, hotel),
            ),
          ),
          Positioned(
            left: 16,
            child: Container(
              child: _carouselItemPortrait(context, hotel),
            ),
          ),
        ],
      );

  _carouselItemDescription(BuildContext context, Hotel hotel) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 62),
              Text(
                hotel.name,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                hotel.address,
                style: Theme.of(context)
                    .textTheme
                    .bodyText2
                    .copyWith(color: Colors.blueGrey[500]),
              ),
              SizedBox(height: 8),
              Text(
                "\$ ${hotel.price} / night",
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  _carouselItemPortrait(BuildContext context, Hotel hotel) => Container(
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
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image(
                width: 248,
                height: 208,
                image: AssetImage(hotel.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 248,
                height: 208,
                color: Colors.black45,
              ),
            )
          ],
        ),
      );
}
