part of 'models.dart';

class UserModel extends UserEntity {
  const UserModel({
    super.id,
    super.username,
    super.email,
    super.password,
    super.phone,
    super.name,
    super.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json.getInt('id'),
        username: json.getString('username'),
        email: json.getString('email'),
        password: json.getString('password'),
        phone: json.getString('phone'),
        name: NameModel.fromJson(json.getMap('name') ?? <String, dynamic>{})
            .toEntitie(),
        address:
            AddressModel.fromJson(json.getMap('address') ?? <String, dynamic>{})
                .toEntitie(),
      );
}

extension BookMapper on UserModel {
  UserEntity toEntitie() {
    return UserEntity(
      id: id,
      username: username,
      email: email,
      password: password,
      phone: phone,
      name: name,
      address: address,
    );
  }
}
