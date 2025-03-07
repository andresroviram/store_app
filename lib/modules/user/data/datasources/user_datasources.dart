import 'package:injectable/injectable.dart';
import '../../../../core/utils/extension/extension.dart';
import '../../../../core/services/services.dart';
import '../end_points.dart';
import '../models/models.dart';

abstract class IUserDatasource {
  Future<List<UserModel>> getUsers();
}

@Injectable(as: IUserDatasource)
class UserDatasource implements IUserDatasource {
  UserDatasource({
    required this.baseClient,
  });

  final BaseClient baseClient;

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      return (await baseClient.get(
        path: EndPoint.usersList,
      ))!
          .withListConverter<UserModel>(
        callback: UserModel.fromJson,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }
}
