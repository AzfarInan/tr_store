import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/feature/product_list/data/model/product_list_model.dart';
import 'package:tr_store/src/feature/product_list/presentation/provider/product_list_provider.dart';

part '../widgets/product_list_shimmer.dart';
part '../widgets/product_item.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends ConsumerState<ProductListScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      ref.read(productListNotifierProvider.notifier).getProductList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(productListNotifierProvider.notifier);
    final state = ref.watch(productListNotifierProvider);

    return RefreshIndicator(
      onRefresh: () async {
        /// TODO: Call API
      },
      child: Scaffold(
        body: SafeArea(
          child: state.status == Status.loading
              ? const ProductListShimmer()
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: notifier.productList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
