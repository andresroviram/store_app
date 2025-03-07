import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repository/user_repository.dart';
import '../datasources/user_datasources.dart';
import '../models/models.dart';

@Injectable(as: IUserRepository)
class UserRepositoryImpl implements IUserRepository {
  UserRepositoryImpl(this.userDatasource);
  final IUserDatasource userDatasource;

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final List<UserModel> users = await userDatasource.getUsers();
      final List<UserEntity> list = users.map((e) => e.toEntitie()).toList();
      return Right(list);
    } on BaseClientException catch (e) {
      log(e.toString());
      if (e.type == 'SocketException') {
        return const Left(NetworkFailure());
      }
      if (e.type == 'TimeoutException') {
        return const Left(TimeOutFailure());
      }
      if (e.type == 'UnAuthorization') {
        return const Left(AuthFailure());
      }
      return const Left(AnotherFailure());
    } catch (e) {
      log(e.toString());
      return const Left(AnotherFailure());
    }
  }
}
