import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/core/services/network_service/utils/request_handler.dart';
import 'package:tr_store/src/feature/product_details/data/data_source/product_details_data_source.dart';
import 'package:tr_store/src/feature/product_details/domain/repository/product_details_repository.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';

class ProductDetailsRepositoryImpl implements ProductDetailsRepository {
  ProductDetailsRepositoryImpl({required this.dataSource});

  final ProductDetailsDataSource dataSource;

  @override
  Future<(ErrorModel?, Product?)> getProductDetails({
    required int productId,
  }) {
    return dataSource.getProductDetails(productId: productId).guard((data) {
      return Product.fromJson(data);
    });
  }
}
