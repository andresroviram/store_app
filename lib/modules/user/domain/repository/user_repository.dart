import 'package:either_dart/either.dart';

import '../../../../core/error/error.dart';
import '../entities/entities.dart';

abstract class IUserRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
}
