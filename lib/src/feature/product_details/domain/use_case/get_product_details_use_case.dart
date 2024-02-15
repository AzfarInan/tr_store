import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/feature/product_details/domain/repository/product_details_repository.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';

class GetProductDetailsUseCase {
  final ProductDetailsRepository repository;

  GetProductDetailsUseCase(this.repository);

  Future<(ErrorModel?, Product?)> call({required int productId}) async {
    return await repository.getProductDetails(productId: productId);
  }
}

final getProductDetailsUseCaseProvider = Provider<GetProductDetailsUseCase>(
  (ref) => GetProductDetailsUseCase(
    ref.read(productDetailsRepositoryProvider),
  ),
);
