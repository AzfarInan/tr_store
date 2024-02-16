import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/core/services/database_service/sql_helper.dart';
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
  int page = 1;
  bool endOfList = false;

  @override
  BaseState build() {
    useCase = ref.read(getProductListUseCaseProvider);
    return BaseState.initial();
  }

  Future<void> getProductList() async {
    final data = await SQLHelper.hasData();

    if (data) {
      getProductListFromDataBase();
    } else {
      getProductListFromAPI();
    }
  }

  Future<void> getProductListFromDataBase() async {
    if (endOfList) {
      return;
    }

    try {
      final data = await SQLHelper.getData(page: page);

      if (data.isEmpty) {
        endOfList = true;
      }

      if (data.isNotEmpty) {
        List<Product> tempList = data.map((e) => Product.fromJson(e)).toList();
        productList.addAll(tempList);
        page++;
        state = BaseState().copyWith(
          status: Status.success,
          data: productList,
        );
      } else {
        state = BaseState().copyWith(
          status: Status.error,
          message: 'No Data Found',
        );
      }
    } on Exception catch (e) {
      state = BaseState().copyWith(
        status: Status.error,
        message: e.toString(),
      );
    }
  }

  Future<void> getProductListFromAPI() async {
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
        List<Map<String, dynamic>> _dataFromDB = [];
        _dataFromDB = data.products!.map((e) => e.toJson()).toList();

        _dataFromDB.forEach((element) async {
          await SQLHelper.insert(element);
        });

        page = 1;
        productList.clear();
        getProductListFromDataBase();

        state = BaseState().copyWith(
          status: Status.success,
          data: productList,
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
