part of 'models.dart';

class GeoModel extends GeoEntity {
  const GeoModel({
    super.lat,
    super.long,
  });

  factory GeoModel.fromJson(Map<String, dynamic> json) => GeoModel(
        lat: json.getString('lat'),
        long: json.getString('long'),
      );
}

extension GeoMapper on GeoModel {
  GeoEntity toEntitie() {
    return GeoEntity(
      lat: lat,
      long: long,
    );
  }
}
