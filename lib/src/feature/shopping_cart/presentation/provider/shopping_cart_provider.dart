import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tr_store/app.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/core/services/database_service/sql_helper.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';

final shoppingCartNotifierProvider =
    NotifierProvider<ShoppingCartNotifier, BaseState>(
  ShoppingCartNotifier.new,
);

class ShoppingCartNotifier extends Notifier<BaseState> {
  ShoppingCartNotifier() : super();

  List<ProductWithQuantity> shoppingCart = [];

  @override
  BaseState build() {
    return BaseState.initial();
  }

  Future<void> addToCart(Product product) async {
    await SQLHelper.addItemToCart(
      ProductWithQuantity(
        id: product.id!,
        title: product.title!,
        thumbnail: product.thumbnail!,
        userId: product.userId!,
        quantity: 1,
      ).toJson(),
    );

    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: product.id,
    );
  }

  Future<int> getQuantity(Product product) async {
    final result = await SQLHelper.getSingleCartItem(product.id!);
    if (result.isNotEmpty) {
      return result['quantity'] as int;
    }

    return 0;
  }

  Future<void> decreaseItem(Product product) async {
    await SQLHelper.reduceItemFromCart(
      ProductWithQuantity(
        id: product.id!,
        title: product.title!,
        thumbnail: product.thumbnail!,
        userId: product.userId!,
        quantity: 1,
      ).toJson(),
    );

    getQuantity(product);
    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: product.id,
    );
  }

  void removeFromCart(Product product) {
    shoppingCart.removeWhere((element) => element.id! == product.id!);

    getQuantity(product);
    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: product.id,
    );
  }

  Future<void> clearCart() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      state = BaseState().copyWith(
        status: Status.noInternet,
        message: 'No Internet Connection!',
      );
      return;
    }

    shoppingCart.clear();
    updateCartLength(reset: true);
    state = BaseState().copyWith(
      status: Status.success,
      data: shoppingCart,
    );
  }

  Future<void> updateCartLength({bool reset = false}) async {
    if (reset) {
      await SQLHelper.clearCart();
      cartLength.value = shoppingCart.length;
      totalCartValue();
    } else {
      final result = await SQLHelper.getCartData();
      shoppingCart = result
          .map((e) => ProductWithQuantity.fromJson(e))
          .toList()
          .cast<ProductWithQuantity>();

      cartLength.value = shoppingCart.length;
      totalCartValue();
    }
  }

  int totalCartValue() {
    int total = 0;
    for (var item in shoppingCart) {
      total += item.userId! * item.quantity!;
    }

    return total;
  }
}
