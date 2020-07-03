import 'package:meta/meta.dart';

final plantIdKey = 'plantId';
final nameKey = 'name';
final descriptionKey = 'description';
final growZoneNumberKey = 'growZoneNumber';
final wateringIntervalKey = 'wateringInterval';
final imageUrlKey = 'imageUrl';

class Plant {
  final String plantId;
  final String name;
  final String description;
  final int growZoneNumber;
  final int wateringInterval;
  final String imageUrl;

  const Plant(
      {@required this.plantId,
      @required this.name,
      @required this.description,
      @required this.growZoneNumber,
      @required this.wateringInterval,
      @required this.imageUrl})
      : assert(plantId != null),
        assert(name != null),
        assert(description != null),
        assert(growZoneNumber != null),
        assert(wateringInterval != null),
        assert(imageUrl != null);

  @override
  bool operator ==(other) {
    return (other is Plant && other.plantId == plantId);
  }

  @override
  int get hashCode => plantId.hashCode;

  Plant.fromJson(Map jsonMap)
      : assert(jsonMap[plantIdKey] != null),
        assert(jsonMap[nameKey] != null),
        assert(jsonMap[descriptionKey] != null),
        assert(jsonMap[growZoneNumberKey] != null),
        plantId = jsonMap[plantIdKey],
        name = jsonMap[nameKey],
        description = jsonMap[descriptionKey],
        growZoneNumber = jsonMap[growZoneNumberKey],
        wateringInterval = jsonMap[wateringIntervalKey],
        imageUrl = jsonMap[imageUrlKey];

  Map<String, dynamic> toMap() => {
        plantIdKey: plantId,
        nameKey: name,
        descriptionKey: description,
        growZoneNumberKey: growZoneNumber,
        wateringIntervalKey: wateringInterval,
        imageUrlKey: imageUrl
      };
}
