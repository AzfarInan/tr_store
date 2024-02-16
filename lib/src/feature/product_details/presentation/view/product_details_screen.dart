import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/core/widgets/app_bar.dart';
import 'package:tr_store/src/core/widgets/button.dart';
import 'package:tr_store/src/feature/product_details/presentation/provider/product_details_provider.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';
import 'package:tr_store/src/feature/shopping_cart/presentation/provider/shopping_cart_provider.dart';

part '../widgets/product_details.dart';
part '../widgets/product_header.dart';
part '../widgets/product_details_shimmer.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({super.key, required this.productId});

  final int productId;

  @override
  ProductDetailsState createState() => ProductDetailsState();
}

class ProductDetailsState extends ConsumerState<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      ref
          .read(productDetailsNotifierProvider.notifier)
          .getProductDetails(productId: widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(productDetailsNotifierProvider.notifier);
    final state = ref.watch(productDetailsNotifierProvider);

    return RefreshIndicator(
      onRefresh: () async {
        await notifier.getProductDetails(productId: widget.productId);
      },
      child: Scaffold(
        appBar: const TRStoreAppBar(title: 'Details'),
        body: SafeArea(
          child: state.status == Status.loading
              ? const _ProductDetailsShimmer()
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      elevation: 0.0,
                      pinned: true,
                      floating: true,
                      snap: true,
                      expandedHeight: 300.h,
                      collapsedHeight: 300.h,
                      flexibleSpace: _ProductHeader(
                        product: notifier.product,
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      fillOverscroll: true,
                      child: _ProductDetails(
                        product: notifier.product,
                      ),
                    ),
                  ],
                ),
        ),
        bottomNavigationBar: state.status == Status.loading
            ? const SizedBox()
            : Container(
                decoration: BoxDecoration(color: Colors.teal.shade50),
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        '\$${notifier.product!.userId}.00',
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
                          ref
                              .read(shoppingCartNotifierProvider.notifier)
                              .addToCart(notifier.product!);
                          // Show SnackBar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 500),
                              content: Center(
                                child: Text(
                                  'Added to cart',
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
                        label: 'Add to Cart',
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        prefix: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
