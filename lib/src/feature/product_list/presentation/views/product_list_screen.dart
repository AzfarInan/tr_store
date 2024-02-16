import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/core/route/tr_store_routes.dart';
import 'package:tr_store/src/core/widgets/app_bar.dart';
import 'package:tr_store/src/core/widgets/error_screen.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';
import 'package:tr_store/src/feature/product_list/presentation/provider/product_list_provider.dart';
import 'package:tr_store/src/feature/shopping_cart/presentation/provider/shopping_cart_provider.dart';

part '../widgets/product_list_shimmer.dart';
part '../widgets/product_item.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends ConsumerState<ProductListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      ref.read(productListNotifierProvider.notifier).getProductList();
      ref.read(shoppingCartNotifierProvider.notifier).updateCartLength();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        ref
            .read(productListNotifierProvider.notifier)
            .getProductListFromDataBase();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(productListNotifierProvider.notifier);
    final state = ref.watch(productListNotifierProvider);

    ref.listen(productListNotifierProvider, (previous, next) {
      if (next.status == Status.noInternet) {
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

    return RefreshIndicator(
      onRefresh: () async {
        await notifier.getProductListFromAPI();
      },
      child: Scaffold(
        appBar: const TRStoreAppBar(
          title: 'Products',
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: state.status == Status.loading
              ? const ProductListShimmer()
              : state.status == Status.error
                  ? const ErrorScreen()
                  : SingleChildScrollView(
                      controller: _scrollController,
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: notifier.productList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16.w,
                              mainAxisSpacing: 16.h,
                              childAspectRatio: 0.8,
                            ),
                            itemBuilder: (context, index) {
                              return ProductItems(
                                product: notifier.productList[index],
                                index: index,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
