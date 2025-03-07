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
import '../authenticate/cubit/auth_cubit.dart' as _i287;
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
    gh.singleton<_i287.AuthCubit>(() => _i287.AuthCubit());
    gh.lazySingleton<_i557.RouterManager>(() => _i557.RouterManager());
    gh.factory<_i499.LocalStorage>(() => _i499.LocalStorageImpl());
    return this;
  }
}
