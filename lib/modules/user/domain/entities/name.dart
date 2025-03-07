part of 'entities.dart';

class NameEntity extends Equatable {
  const NameEntity({
    this.firstname,
    this.lastname,
  });

  final String? firstname;
  final String? lastname;

  factory NameEntity.empty() => const NameEntity();

  @override
  List<Object?> get props => [
        firstname,
        lastname,
      ];
}
