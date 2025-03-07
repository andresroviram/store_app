import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _prefLoggedIn = 'isLoggedIn';

abstract class LocalStorage {
  Future<bool> getLoggedIn();
  Future<void> setLoggedIn(bool value);
}

@Injectable(as: LocalStorage)
class LocalStorageImpl implements LocalStorage {
  @override
  Future<bool> getLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_prefLoggedIn) ?? false;
  }

  @override
  Future<void> setLoggedIn(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool(_prefLoggedIn, value);
  }
}
