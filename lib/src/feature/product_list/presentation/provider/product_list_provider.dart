import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';
import 'package:tr_store/src/feature/product_list/domain/use_case/product_list_use_case.dart';

final productListNotifierProvider =
    NotifierProvider<ProductListNotifier, BaseState>(
  ProductListNotifier.new,
);

class ProductListNotifier extends Notifier<BaseState> {
  ProductListNotifier() : super();

  late final GetProductListUseCase useCase;
  List<Product> productList = [];

  @override
  BaseState build() {
    useCase = ref.read(getProductListUseCaseProvider);
    return BaseState.initial();
  }

  Future<void> getProductList() async {
    state = BaseState.loading();

    try {
      ErrorModel? errorModel;
      ProductList? data;

      (errorModel, data) = await useCase();

      if (errorModel != null) {
        state = BaseState().copyWith(
          status: Status.error,
          data: errorModel,
        );
      }

      if (data != null) {
        productList = data.products!;
        state = BaseState().copyWith(
          status: Status.success,
          data: data,
        );
      }
    } on Exception catch (e) {
      state = BaseState().copyWith(
        status: Status.error,
        message: e.toString(),
      );
    }
  }
}
