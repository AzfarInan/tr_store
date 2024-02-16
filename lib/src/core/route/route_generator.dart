import 'package:flutter/material.dart';
import 'package:tr_store/src/core/route/tr_store_routes.dart';
import 'package:tr_store/src/feature/product_details/presentation/view/product_details_screen.dart';
import 'package:tr_store/src/feature/product_list/presentation/views/product_list_screen.dart';
import 'package:tr_store/src/feature/shopping_cart/presentation/view/shopping_cart_screen.dart';
import 'package:tr_store/src/feature/splash/presentation/views/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case TRStoreRoute.splash:
        return MaterialPageRoute(
          settings: const RouteSettings(name: TRStoreRoute.splash),
          builder: (_) => const SplashScreen(),
        );

      case TRStoreRoute.productList:
        return MaterialPageRoute(
          settings: const RouteSettings(name: TRStoreRoute.productList),
          builder: (_) => const ProductListScreen(),
        );

      case TRStoreRoute.productDetails:
        int? productId;
        if (args is int) {
          productId = args;
        }
        return MaterialPageRoute(
          settings: const RouteSettings(name: TRStoreRoute.productDetails),
          builder: (_) => ProductDetailsScreen(productId: productId ?? 0),
        );

      case TRStoreRoute.shoppingCart:
        return MaterialPageRoute(
          settings: const RouteSettings(name: TRStoreRoute.shoppingCart),
          builder: (_) => const ShoppingCartScreen(),
        );

      default:
        return null;
    }
  }
}
