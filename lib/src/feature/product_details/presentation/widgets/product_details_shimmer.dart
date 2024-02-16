part of '../view/product_details_screen.dart';

class _ProductDetailsShimmer extends StatelessWidget {
  const _ProductDetailsShimmer();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: Colors.black12,
              highlightColor: Colors.grey.shade300,
              child: Container(
                height: 200.h,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.h),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: 16.h,
                width: double.infinity,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4.h),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: 16.h,
                width: 200.w,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 32.h),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                height: 16.h,
                width: 100.w,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.h),
            ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.white,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    height: 16.h,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                );
              },
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.white,
              child: Container(
                margin: EdgeInsets.only(bottom: 8.h),
                height: 16.h,
                width: 200.w,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
