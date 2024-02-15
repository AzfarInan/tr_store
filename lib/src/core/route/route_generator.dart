import 'package:flutter/material.dart';
import 'package:tr_store/src/core/route/tr_store_routes.dart';
import 'package:tr_store/src/feature/product_list/presentation/views/product_list_screen.dart';
import 'package:tr_store/src/feature/splash/presentation/views/splash_screen.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
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

      default:
        return null;
    }
  }
}
