part of 'models.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    super.id,
    super.title,
    super.price,
    super.description,
    super.category,
    super.image,
    super.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json.getInt('id'),
        title: json.getString('title'),
        price: json.getDouble('price'),
        description: json.getString('description'),
        category: json.getString('category'),
        image: json.getString('image'),
        rating:
            RatingModel.fromJson(json.getMap('rating') ?? <String, dynamic>{})
                .toEntitie(),
      );
}

extension BookMapper on ProductModel {
  ProductEntity toEntitie() {
    return ProductEntity(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating,
    );
  }
}
