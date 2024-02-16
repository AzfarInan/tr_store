part of '../view/shopping_cart_screen.dart';

class _CartItem extends ConsumerStatefulWidget {
  const _CartItem({required this.product});

  final Product product;

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends ConsumerState<_CartItem> {
  @override
  Widget build(BuildContext context) {
    final notifier = ref.watch(shoppingCartNotifierProvider.notifier);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.product.thumbnail!,
                height: 100.h,
                width: 100.w,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Flexible(
            fit: FlexFit.tight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${widget.product.userId!}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    /// Increment & Decrement Button
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            notifier.decreaseItem(widget.product);
                          },
                          icon: const Icon(
                            Icons.remove_circle_outlined,
                            color: Colors.teal,
                          ),
                        ),
                        Text(
                          notifier.getQuantity(widget.product).toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            notifier.addToCart(widget.product);
                          },
                          icon: const Icon(
                            Icons.add_circle_outlined,
                            color: Colors.teal,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
        ],
      ),
    );
  }
}
