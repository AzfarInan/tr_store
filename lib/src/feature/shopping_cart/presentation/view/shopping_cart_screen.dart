import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/core/widgets/app_bar.dart';
import 'package:tr_store/src/core/widgets/button.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';
import 'package:tr_store/src/feature/shopping_cart/presentation/provider/shopping_cart_provider.dart';

part '../widget/cart_item.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ShoppingCartState createState() => ShoppingCartState();
}

class ShoppingCartState extends ConsumerState<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(shoppingCartNotifierProvider.notifier);

    ref.listen(shoppingCartNotifierProvider, (previous, next) {
      if (next.status == Status.success) {
        setState(() {});
      } else if (next.status == Status.noInternet) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.message!,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
              ),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    return Scaffold(
      appBar: const TRStoreAppBar(
        title: 'Shopping Cart',
        showShoppingCart: false,
      ),
      body: notifier.shoppingCart.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart,
                    size: 100.w,
                    color: Colors.grey.shade500,
                  ),
                  Text(
                    'No Item in Cart',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: notifier.shoppingCart.length,
                    itemBuilder: (context, index) {
                      return _CartItem(
                        product: Product.fromModel(
                          notifier.shoppingCart[index],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 4.h);
                    },
                  ),
                ],
              ),
            ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.teal.shade50),
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Total: \$${notifier.totalCartValue()}.00',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Button(
                onPressed: () {
                  notifier.clearCart();
                  // Show SnackBar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 500),
                      content: Center(
                        child: Text(
                          'Order Placed!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  );
                },
                borderRadius: 12.r,
                label: 'Confirm Order',
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
