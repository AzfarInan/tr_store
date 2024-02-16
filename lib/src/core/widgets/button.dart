import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.label,
    required this.onPressed,
    this.background,
    this.textStyle,
    this.height = 60,
    this.width = double.infinity,
    this.isLoading = false,
    this.prefix,
    this.disable = false,
    this.borderRadius = 4,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String label;
  final Color? background;
  final TextStyle? textStyle;
  final double height;
  final double width;
  final bool isLoading;
  final Widget? prefix;
  final bool disable;
  final double borderRadius;

  factory Button.filled({
    required String label,
    required VoidCallback onPressed,
    Color? background,
    TextStyle? textStyle,
    double height = 60,
    double width = double.infinity,
    bool isLoading = false,
    Widget? prefix,
    bool disable = false,
  }) {
    return Button(
      label: label,
      onPressed: onPressed,
      background: background,
      textStyle: textStyle,
      height: height,
      width: width,
      isLoading: isLoading,
      prefix: prefix,
      disable: disable,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = this.height;

    return DecoratedBox(
      decoration: disable
          ? const BoxDecoration()
          : BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
      child: ElevatedButton(
        onPressed: disable
            ? null
            : isLoading
                ? null
                : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          padding: EdgeInsets.zero,
          fixedSize: Size(width, height),
          backgroundColor: background ?? Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isLoading
                ? Transform.scale(
                    scale: 1,
                    child: const SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  )
                : prefix == null
                    ? Text(
                        label,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      )
                    : Row(
                        children: [
                          prefix!,
                          const SizedBox(width: 10),
                          Text(
                            label,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
