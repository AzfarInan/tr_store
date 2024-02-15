import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/feature/product_details/data/data_source/product_details_data_source.dart';
import 'package:tr_store/src/feature/product_details/data/repository/product_details_repository_impl.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';

abstract class ProductDetailsRepository {
  Future<(ErrorModel?, Product?)> getProductDetails({
    required int productId,
  });
}

final productDetailsRepositoryProvider = Provider<ProductDetailsRepository>(
  (ref) => ProductDetailsRepositoryImpl(
    dataSource: ref.read(productDetailsDataSourceProvider),
  ),
);
