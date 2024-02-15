import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';
import 'package:tr_store/src/feature/product_list/domain/repository/product_list_repository.dart';

class GetProductListUseCase {
  final ProductListRepository repository;

  GetProductListUseCase(this.repository);

  Future<(ErrorModel?, ProductList?)> call() async {
    return await repository.getProductList();
  }
}

final getProductListUseCaseProvider = Provider<GetProductListUseCase>(
  (ref) => GetProductListUseCase(
    ref.read(productListRepositoryProvider),
  ),
);
