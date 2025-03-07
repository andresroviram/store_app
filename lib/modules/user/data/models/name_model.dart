part of 'models.dart';

class NameModel extends NameEntity {
  const NameModel({
    super.firstname,
    super.lastname,
  });

  factory NameModel.fromJson(Map<String, dynamic> json) => NameModel(
        firstname: json.getString('firstname'),
        lastname: json.getString('lastname'),
      );
}

extension NameMapper on NameModel {
  NameEntity toEntitie() {
    return NameEntity(
      firstname: firstname,
      lastname: lastname,
    );
  }
}
