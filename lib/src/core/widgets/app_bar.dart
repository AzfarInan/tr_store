import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/app.dart';
import 'package:tr_store/src/core/route/tr_store_routes.dart';

class TRStoreAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  const TRStoreAppBar({
    super.key,
    required this.title,
    this.automaticallyImplyLeading = true,
    this.showShoppingCart = true,
  });

  final String title;
  final bool automaticallyImplyLeading;
  final bool showShoppingCart;

  @override
  TRStoreAppBarState createState() => TRStoreAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TRStoreAppBarState extends ConsumerState<TRStoreAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      actions: widget.showShoppingCart
          ? [
              Stack(
                children: [
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        /// Navigate to shopping cart screen
                        Navigator.of(context).pushNamed(
                          TRStoreRoute.shoppingCart,
                        );
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: ValueListenableBuilder(
                        valueListenable: cartLength,
                        builder: (context, value, child) {
                          return Text(
                            value.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
            ]
          : [],
      centerTitle: true,
      backgroundColor: Colors.teal,
      elevation: 0.h,
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
    );
  }
}
