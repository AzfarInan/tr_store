import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/core/services/network_service/utils/request_handler.dart';
import 'package:tr_store/src/feature/product_list/data/data_source/product_list_data_source.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';
import 'package:tr_store/src/feature/product_list/domain/repository/product_list_repository.dart';

class ProductListRepositoryImpl implements ProductListRepository {
  ProductListRepositoryImpl({required this.dataSource});

  final ProductListDataSource dataSource;

  @override
  Future<(ErrorModel?, ProductList?)> getProductList() {
    return dataSource.getProductList().guard((data) {
      return ProductList.fromJson(data);
    });
  }
}
