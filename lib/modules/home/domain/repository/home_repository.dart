import 'package:either_dart/either.dart';

import '../../../../core/error/error.dart';
import '../entities/entities.dart';

abstract class IHomeRepository {
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  Future<Either<Failure, ProductEntity>> getProductDetail(String id);
}
