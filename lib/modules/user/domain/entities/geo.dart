part of 'entities.dart';

class GeoEntity extends Equatable {
  const GeoEntity({
    this.lat,
    this.long,
  });

  final String? lat;
  final String? long;

  bool get isNull => lat == null || long == null;

  factory GeoEntity.empty() => const GeoEntity();

  @override
  List<Object?> get props => [
        lat,
        long,
      ];
}
