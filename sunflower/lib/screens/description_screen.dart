import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sunflower/model/plant.dart';
import 'package:sunflower/repo/plants_repo.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class DescriptionScreen extends StatefulWidget {
  final Plant plant;
  final LoadPlantsRepo repo;
  final bool isInGarden;

  DescriptionScreen(
      {@required this.plant, @required this.repo, @required this.isInGarden});

  @override
  _DescriptionScreenState createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  ScrollController _scrollController = new ScrollController();

  final backgroundHeight = 256.0;
  bool isInGarden;

  @override
  void initState() {
    super.initState();
    isInGarden = widget.isInGarden;
    _scrollController = new ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold(context);
  }

  _scaffold(BuildContext context) => Scaffold(
        body: new Stack(
          children: [
            new CustomScrollView(
              controller: _scrollController,
              slivers: [
                _sliverAppBar(),
                _descriptionList(),
              ],
            ),
            _fab(context),
          ],
        ),
      );

  _sliverAppBar() => SliverAppBar(
        expandedHeight: backgroundHeight,
        floating: true,
        pinned: true,
        snap: true,
        leading: _buildNavigationUpIcon(context),
        actions: [_buildShareIcon(context)],
        flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(
              widget.plant.name,
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            background: _buildBackground()),
      );

  _buildNavigationUpIcon(BuildContext context) => IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () => Navigator.of(context).pop(),
      );

  _buildShareIcon(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.share,
          size: 27,
          color: Colors.white,
        ),
      );

  _buildBackground() => Hero(
        tag: widget.plant.plantId,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: widget.plant.imageUrl,
              fit: BoxFit.cover,
            ),
            Container(
              color: Colors.black38,
            )
          ],
        ),
      );

  _descriptionList() => SliverList(
        delegate: new SliverChildListDelegate([
          Column(
            children: <Widget>[
              SizedBox(height: 16),
              Text(
                "Watering needs",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontSize: 17, color: Theme.of(context).accentColor),
              ),
              SizedBox(height: 4),
              Text(
                "Every ${widget.plant.wateringInterval} days",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontSize: 15, color: Colors.grey[700]),
              ),
              Container(
                  padding: EdgeInsets.all(16),
                  child: Html(
                    data: widget.plant.description,
                    defaultTextStyle: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(fontSize: 17, color: Colors.grey[700]),
                    onLinkTap: (url) {
                      _launchURL(url);
                    },
                  )),
            ],
          ),
        ]),
      );

  Widget _fab(BuildContext context) {
    //starting fab position
    final double defaultTopMargin = backgroundHeight + 15;
    //pixels from top where scaling should start
    final double scaleStart = 96.0;
    //pixels from top where scaling should end
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        //offset small => don't scale down
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        //offset between scaleStart and scaleEnd => scale down
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        //offset passed scaleEnd => hide fab
        scale = 0.0;
      }
    }
    return new Positioned(
      top: top,
      right: 16.0,
      child: new Transform(
        transform: new Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: new FloatingActionButton(
          backgroundColor: Colors.yellow,
          onPressed: () => _onFabClicked(context),
          child: new Icon(
            isInGarden ? Icons.delete : Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _onFabClicked(BuildContext context) {
    if (isInGarden) {
      widget.repo.deletePlantFromGarden(widget.plant).then((isDeleted) {
        if (isDeleted) {
          Toast.show("Plant removed from garden", context);
          setState(() => isInGarden = false);
        }
      });
    } else {
      widget.repo.insertPlantToGarden(widget.plant).then((isAdded) {
        if (isAdded) {
          Toast.show("Plant added to garden", context);
          setState(() => isInGarden = true);
        }
      });
    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
