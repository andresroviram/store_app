import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repository/home_repository.dart';
import '../datasources/home_datasources.dart';
import '../models/models.dart';

@Injectable(as: IHomeRepository)
class HomeRepositoryImpl implements IHomeRepository {
  HomeRepositoryImpl(this.homeDatasource);
  final IHomeDatasource homeDatasource;

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final List<ProductModel> products = await homeDatasource.getProducts();
      final List<ProductEntity> list =
          products.map((e) => e.toEntitie()).toList();
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

  @override
  Future<Either<Failure, ProductEntity>> getProductDetail(String id) async {
    try {
      final ProductModel product = await homeDatasource.getProductDetail(id);
      return Right(product.toEntitie());
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
