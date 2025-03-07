part of 'entities.dart';

class RatingEntity extends Equatable {
  const RatingEntity({
    this.rate,
    this.count,
  });

  final double? rate;
  final int? count;

  factory RatingEntity.empty() => const RatingEntity();

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
