part of 'models.dart';

class RatingModel extends RatingEntity {
  const RatingModel({
    super.rate,
    super.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        rate: json.getDouble('rate'),
        count: json.getInt('count'),
      );
}

extension RatingMapper on RatingModel {
  RatingEntity toEntitie() {
    return RatingEntity(
      rate: rate,
      count: count,
    );
  }
}
