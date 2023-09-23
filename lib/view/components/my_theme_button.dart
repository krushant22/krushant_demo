import 'package:flutter/material.dart';
import 'package:krushant_demo/theme/color/colors.dart';
import 'package:krushant_demo/view/components/my_regular_text.dart';

class MyThemeButton extends StatelessWidget {
  final String? buttonText;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? fontColor;
  final double? fontSize;
  final double? height;
  final double? width;
  final double? letterSpacing;
  final Widget? child;
  final ShapeBorder? shape;
  final EdgeInsetsGeometry? padding;

  const MyThemeButton({
    Key? key,
    @required this.buttonText,
    this.color = primaryButtonColor,
    this.onPressed,
    this.fontSize = 16.0,
    this.height,
    this.width,
    this.child,
    this.padding,
    this.letterSpacing,
    this.shape,
    this.fontColor = buttonTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return InkWell(
      splashFactory:  NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onPressed,
      child: Container(
        height:  height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
                colors: [
                  buttonFirstColor,
                  buttonSecondColor,
                ]
            )
        ),
        child: Center(
          child: MyRegularText(label: buttonText ?? "ADD NAME !!!!", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
