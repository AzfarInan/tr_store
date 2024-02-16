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

  List<Map<Product, int>> cartMap = [];

  @override
  BaseState build() {
    return BaseState.initial();
  }

  void addToCart(Product product) {
    int count = 0;
    for (var item in cartMap) {
      if (item.containsKey(product)) {
        count++;
        item[product] = item[product]! + 1;
      }
    }

    if (count == 0) {
      cartMap.add({product: 1});
    }

    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: cartMap,
    );
  }

  int getQuantity(Product product) {
    for (var item in cartMap) {
      if (item.containsKey(product)) {
        return item[product]!;
      }
    }
    return 0;
  }

  void decreaseItem(Product product) {
    state = BaseState().copyWith(
      status: Status.loading,
    );

    for (var item in cartMap) {
      if (item.containsKey(product)) {
        if (item[product]! > 1) {
          item[product] = item[product]! - 1;
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
      data: cartMap,
    );
  }

  void removeFromCart(Product product) {
    cartMap.removeWhere((element) => element.containsKey(product));

    getQuantity(product);
    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: cartMap,
    );
  }

  void clearCart() {
    cartMap.clear();
    updateCartLength();
    state = BaseState().copyWith(
      status: Status.success,
      data: cartMap,
    );
  }

  void updateCartLength() {
    cartLength.value = cartMap.length;
    totalCartValue();
  }

  int totalCartValue() {
    int total = 0;
    for (var item in cartMap) {
      item.forEach((key, value) {
        total += key.userId! * value;
      });
    }

    return total;
  }
}
