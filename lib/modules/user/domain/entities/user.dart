part of 'entities.dart';

class UserEntity extends Equatable {
  const UserEntity({
    this.id,
    this.username,
    this.email,
    this.password,
    this.phone,
    this.name,
    this.address,
  });

  final int? id;
  final String? username;
  final String? email;
  final String? password;
  final String? phone;
  final NameEntity? name;
  final AddressEntity? address;

  bool get isNull => id == null;

  factory UserEntity.empty() => const UserEntity();

  @override
  List<Object?> get props => [
        id,
        username,
        email,
        password,
        phone,
        name,
        address,
      ];
}
