import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/core/services/database_service/sql_helper.dart';
import 'package:tr_store/src/core/services/network_service/utils/error_model.dart';
import 'package:tr_store/src/feature/product_details/domain/use_case/get_product_details_use_case.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';

final productDetailsNotifierProvider =
    NotifierProvider<ProductDetailsNotifier, BaseState>(
  ProductDetailsNotifier.new,
);

class ProductDetailsNotifier extends Notifier<BaseState> {
  ProductDetailsNotifier() : super();

  late final GetProductDetailsUseCase useCase;
  Product? product;

  @override
  BaseState build() {
    useCase = ref.read(getProductDetailsUseCaseProvider);
    BaseState.initial();
    return BaseState.loading();
  }

  Future<void> getProductDetails({required int productId}) async {
    final data = await SQLHelper.getProductById(productId);

    if (data.isNotEmpty) {
      getProductDetailsFromDataBase(data);
    } else {
      getProductDetailsFromAPI(productId: productId);
    }
  }

  Future<void> getProductDetailsFromDataBase(Map<String, dynamic> p) async {
    product = Product.fromJson(p);
    state = BaseState().copyWith(
      status: Status.success,
      data: product,
    );
  }

  Future<void> getProductDetailsFromAPI({required int productId}) async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      state = BaseState().copyWith(
        status: Status.noInternet,
        message: 'No Internet Connection!',
      );
      return;
    }

    state = BaseState.loading();

    try {
      ErrorModel? errorModel;
      Product? data;

      (errorModel, data) = await useCase(productId: productId);

      if (errorModel != null) {
        state = BaseState().copyWith(
          status: Status.error,
          data: errorModel,
        );
      }

      if (data != null) {
        product = data;
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
