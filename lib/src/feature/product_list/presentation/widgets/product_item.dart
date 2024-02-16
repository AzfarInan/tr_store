part of '../views/product_list_screen.dart';

class ProductItems extends ConsumerStatefulWidget {
  const ProductItems({
    super.key,
    required this.product,
    required this.index,
  });

  final Product product;
  final int index;

  @override
  ProductItemsState createState() => ProductItemsState();
}

class ProductItemsState extends ConsumerState<ProductItems> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        InkWell(
          onTap: () {
            /// Navigate to Product Details Page
            Navigator.pushNamed(
              context,
              TRStoreRoute.productDetails,
              arguments: widget.product.id!,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: Image.network(
                    widget.product.thumbnail!,
                    height: 150.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  height: 1.w,
                  width: double.infinity,
                ),
                Padding(
                  padding: EdgeInsets.all(6.w),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.title!,
                          maxLines: 2,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 6.h,
          right: 6.w,
          child: CircleAvatar(
            child: IconButton(
              onPressed: () {
                ref
                    .read(shoppingCartNotifierProvider.notifier)
                    .addToCart(widget.product);

                /// Show SnackBar
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
              icon: const Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
