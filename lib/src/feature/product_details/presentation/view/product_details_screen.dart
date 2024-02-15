import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tr_store/src/core/base/base_state.dart';
import 'package:tr_store/src/feature/product_details/presentation/provider/product_details_provider.dart';

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Details',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.teal,
          elevation: 0,
          actions: [
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
          ],
        ),
        body: SafeArea(
          child: state.status == Status.loading
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 20.h,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  ),
                ),
        ),
      ),
    );
  }
}
