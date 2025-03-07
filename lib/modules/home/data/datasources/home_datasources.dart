import 'package:injectable/injectable.dart';
import '../../../../core/utils/extension/extension.dart';
import '../../../../core/services/services.dart';
import '../end_points.dart';
import '../models/models.dart';

abstract class IHomeDatasource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductDetail(String id);
}

@Injectable(as: IHomeDatasource)
class HomeDatasource implements IHomeDatasource {
  HomeDatasource({
    required this.baseClient,
  });

  final BaseClient baseClient;

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      return (await baseClient.get(
        path: EndPoint.productList,
      ))!
          .withListConverter<ProductModel>(
        callback: ProductModel.fromJson,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductDetail(String id) async {
    try {
      return (await baseClient.get(
        path: EndPoint.productDetail.toParamUrl(<String, String>{
          'id': id,
        })!,
      ))!
          .withConverter<ProductModel>(
        callback: ProductModel.fromJson,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }
}
