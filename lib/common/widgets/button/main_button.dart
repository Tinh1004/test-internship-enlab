import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_internship_enlab/themes/app_colors.dart';
import 'package:test_internship_enlab/themes/styles_text.dart';

class MainButton extends StatelessWidget {
  const MainButton({
    Key? key,
    this.title,
    required this.onPressed,
    this.backgroundColor,
    this.radius,
    this.minWidth,
    this.height,
    this.textStyle,
    this.widgetInButton,
  }) : super(key: key);

  final String? title;
  final Color? backgroundColor;
  final double? radius;
  final Function() onPressed;
  final double? minWidth;
  final double? height;
  final TextStyle? textStyle;
  final Widget? widgetInButton;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(radius ?? 30.r),
      color: backgroundColor ?? AppColors.primary1,
      child: MaterialButton(
        minWidth: minWidth ?? 1.sw,
        height: height ?? 30.h,
        onPressed: () => onPressed(),
        child: widgetInButton ??
            Text(
              title ?? "",
              style: textStyle ?? StylesText.body2,
            ),
      ),
    );
  }
}
