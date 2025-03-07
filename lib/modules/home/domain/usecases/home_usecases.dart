import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/error.dart';
import '../entities/entities.dart';
import '../repository/home_repository.dart';

@lazySingleton
class HomeUseCase {
  HomeUseCase(this.homeRepository);
  final IHomeRepository homeRepository;

  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    return homeRepository.getProducts();
  }

  Future<Either<Failure, ProductEntity>> getProductDetail(String id) async {
    return homeRepository.getProductDetail(id);
  }
}
