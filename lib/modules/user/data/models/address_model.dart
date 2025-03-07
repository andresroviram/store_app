part of 'models.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    super.number,
    super.street,
    super.city,
    super.zipcode,
    super.geolocation,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json.getString('street'),
        number: json.getInt('number'),
        city: json.getString('city'),
        zipcode: json.getString('zipcode'),
        geolocation:
            GeoModel.fromJson(json.getMap('geolocation') ?? <String, dynamic>{})
                .toEntitie(),
      );
}

extension AddressMapper on AddressModel {
  AddressEntity toEntitie() {
    return AddressEntity(
      street: street,
      number: number,
      city: city,
      zipcode: zipcode,
      geolocation: geolocation,
    );
  }
}
