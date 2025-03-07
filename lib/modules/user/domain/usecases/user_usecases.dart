import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error.dart';
import '../entities/entities.dart';
import '../repository/user_repository.dart';

@lazySingleton
class UserUseCase {
  UserUseCase(this.useRepository);
  final IUserRepository useRepository;

  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    return useRepository.getUsers();
  }
}
