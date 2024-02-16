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
    // if (shoppingCart.isEmpty) {
    //   shoppingCart.add(
    //     ProductWithQuantity(
    //       id: product.id,
    //       title: product.title,
    //       thumbnail: product.thumbnail,
    //       userId: product.userId,
    //       quantity: 1,
    //     ),
    //   );
    // } else {
    //   int count = 0;
    //
    //   for (var item in shoppingCart) {
    //     if (item.id == product.id) {
    //       count++;
    //       item.quantity = item.quantity! + 1;
    //
    //       /// Break the loop after first find
    //       break;
    //     }
    //   }
    //
    //   if (count == 0) {
    //     shoppingCart.add(
    //       ProductWithQuantity(
    //         id: product.id,
    //         title: product.title,
    //         thumbnail: product.thumbnail,
    //         userId: product.userId,
    //         quantity: 1,
    //       ),
    //     );
    //   }
    // }
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
      data: shoppingCart,
    );
  }

  Future<int> getQuantity(Product product) async {
    // for (var item in shoppingCart) {
    //   if (item.id == product.id) {
    //     return item.quantity!;
    //   }
    // }

    final result = await SQLHelper.getSingleCartItem(product.id!);
    if (result.isNotEmpty) {
      return result['quantity'] as int;
    }

    return 0;
  }

  Future<void> decreaseItem(Product product) async {
    // state = BaseState().copyWith(
    //   status: Status.loading,
    // );

    // for (var item in shoppingCart) {
    //   if (item.id == product.id) {
    //     if (item.quantity! > 1) {
    //       item.quantity = item.quantity! - 1;
    //     } else {
    //       removeFromCart(product);
    //     }
    //
    //     /// Break the loop after first find
    //     break;
    //   }
    // }

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
      data: shoppingCart,
    );
  }

  void removeFromCart(Product product) {
    // state = BaseState().copyWith(
    //   status: Status.loading,
    // );

    shoppingCart.removeWhere((element) => element.id! == product.id!);

    getQuantity(product);
    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: shoppingCart,
    );
  }

  Future<void> clearCart() async {
    // state = BaseState().copyWith(
    //   status: Status.loading,
    // );

    bool result = await InternetConnectionChecker().hasConnection;
    if (!result) {
      state = BaseState().copyWith(
        status: Status.error,
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
