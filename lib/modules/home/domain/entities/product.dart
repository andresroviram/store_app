part of 'entities.dart';

class ProductEntity extends Equatable {
  const ProductEntity({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  final int? id;
  final String? title;
  final double? price;
  final String? description;
  final String? category;
  final String? image;
  final RatingEntity? rating;

  bool get isNull => id == null;

  factory ProductEntity.empty() => const ProductEntity();

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}
