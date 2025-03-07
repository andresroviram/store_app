// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../core/services/local_storage.dart' as _i499;
import '../../core/services/services.dart' as _i514;
import '../../modules/home/data/datasources/home_datasources.dart' as _i896;
import '../../modules/home/data/repository/home_repository.dart' as _i427;
import '../../modules/home/domain/repository/home_repository.dart' as _i580;
import '../../modules/home/domain/usecases/home_usecases.dart' as _i1023;
import '../../modules/user/data/datasources/user_datasources.dart' as _i328;
import '../../modules/user/data/repository/user_repository.dart' as _i464;
import '../../modules/user/domain/repository/user_repository.dart' as _i871;
import '../../modules/user/domain/usecases/user_usecases.dart' as _i232;
import '../authenticate/cubit/auth_cubit.dart' as _i287;
import '../env/env.dart' as _i879;
import '../routes/cubit/router_manager.dart' as _i557;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i879.Env>(() => _i879.Env());
    gh.singleton<_i287.AuthCubit>(() => _i287.AuthCubit());
    gh.lazySingleton<_i557.RouterManager>(() => _i557.RouterManager());
    gh.factory<_i499.LocalStorage>(() => _i499.LocalStorageImpl());
    gh.lazySingleton<_i514.BaseClient>(() => _i514.BaseClient(gh<_i879.Env>()));
    gh.factory<_i328.IUserDatasource>(
        () => _i328.UserDatasource(baseClient: gh<_i514.BaseClient>()));
    gh.factory<_i896.IHomeDatasource>(
        () => _i896.HomeDatasource(baseClient: gh<_i514.BaseClient>()));
    gh.factory<_i580.IHomeRepository>(
        () => _i427.HomeRepositoryImpl(gh<_i896.IHomeDatasource>()));
    gh.lazySingleton<_i1023.HomeUseCase>(
        () => _i1023.HomeUseCase(gh<_i580.IHomeRepository>()));
    gh.factory<_i871.IUserRepository>(
        () => _i464.UserRepositoryImpl(gh<_i328.IUserDatasource>()));
    gh.lazySingleton<_i232.UserUseCase>(
        () => _i232.UserUseCase(gh<_i871.IUserRepository>()));
    return this;
  }
}
