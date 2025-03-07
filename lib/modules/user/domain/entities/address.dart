part of 'entities.dart';

class AddressEntity extends Equatable {
  const AddressEntity({
    this.street,
    this.number,
    this.city,
    this.zipcode,
    this.geolocation,
  });

  final String? street;
  final int? number;
  final String? city;
  final String? zipcode;
  final GeoEntity? geolocation;

  bool get isNull => street == null;

  factory AddressEntity.empty() => const AddressEntity();

  @override
  List<Object?> get props => [
        street,
        number,
        city,
        zipcode,
        geolocation,
      ];
}
