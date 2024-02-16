import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tr_store/app.dart';
import 'package:tr_store/src/core/base/base_state.dart';
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

  void addToCart(Product product) {
    if (shoppingCart.isEmpty) {
      shoppingCart.add(ProductWithQuantity(product: product, quantity: 1));
    } else {
      int count = 0;

      for (var item in shoppingCart) {
        if (item.product!.id == product.id) {
          count++;
          item.quantity = item.quantity! + 1;

          /// Break the loop after first find
          break;
        }
      }

      if (count == 0) {
        shoppingCart.add(ProductWithQuantity(product: product, quantity: 1));
      }
    }

    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: shoppingCart,
    );
  }

  int getQuantity(Product product) {
    for (var item in shoppingCart) {
      if (item.product!.id == product.id) {
        return item.quantity!;
      }
    }
    return 0;
  }

  void decreaseItem(Product product) {
    state = BaseState().copyWith(
      status: Status.loading,
    );

    for (var item in shoppingCart) {
      if (item.product!.id == product.id) {
        if (item.quantity! > 1) {
          item.quantity = item.quantity! - 1;
        } else {
          removeFromCart(product);
        }

        /// Break the loop after first find
        break;
      }
    }

    getQuantity(product);
    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: shoppingCart,
    );
  }

  void removeFromCart(Product product) {
    state = BaseState().copyWith(
      status: Status.loading,
    );

    shoppingCart.removeWhere((element) => element.product!.id == product.id);

    getQuantity(product);
    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: shoppingCart,
    );
  }

  void clearCart() {
    state = BaseState().copyWith(
      status: Status.loading,
    );

    shoppingCart.clear();
    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: shoppingCart,
    );
  }

  void updateCartLength() {
    cartLength.value = shoppingCart.length;
    totalCartValue();
  }

  int totalCartValue() {
    int total = 0;
    for (var item in shoppingCart) {
      total += item.product!.userId! * item.quantity!;
    }

    return total;
  }
}
