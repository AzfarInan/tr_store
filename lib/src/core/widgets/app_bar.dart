import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TRStoreAppBar extends StatelessWidget implements PreferredSizeWidget {
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
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 24,
        ),
      ),
      actions: showShoppingCart
          ? [
              CircleAvatar(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
            ]
          : [],
      centerTitle: true,
      backgroundColor: Colors.teal,
      elevation: 0.h,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
