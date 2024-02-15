import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/feature/product_list/data/data_source/product_list_data_source.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';
import 'package:tr_store/src/feature/product_list/data/repository/product_list_repository_impl.dart';

abstract class ProductListRepository {
  Future<(ErrorModel?, ProductList?)> getProductList();
}

final productListRepositoryProvider = Provider<ProductListRepository>(
  (ref) => ProductListRepositoryImpl(
    dataSource: ref.read(productListDataSourceProvider),
  ),
);
