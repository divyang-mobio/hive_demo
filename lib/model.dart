import 'package:hive/hive.dart';

part 'model.g.dart';

@HiveType(typeId: 0)
class LocationData extends HiveObject {

  @HiveField(0)
  double latitude;

  @HiveField(1)
  double longitude;

  LocationData({required this.latitude, required this.longitude});

  factory LocationData.fromJson(Map<String, dynamic> json) =>
      LocationData(latitude: json['latitude'], longitude: json["longitude"]);

  Map<String, dynamic> toJson() => {
        'longitude': longitude,
        'latitude': latitude,
      };
}
