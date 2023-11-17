import 'package:flutter/material.dart';

import '../../util/color_constants.dart';
import '../../util/dimensions.dart';
import '../../util/styles.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final bool transparent;
  final bool backgroundTransparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final double? radius;
  final IconData? icon;
  final BoxDecoration? boxDecoration;
  const CustomButton(
      {Key? key,
      required this.onPressed,
      required this.buttonText,
      this.transparent = false,
      this.backgroundTransparent = false,
      this.margin,
      this.textColor,
      this.width,
      this.height,
      this.fontSize,
      this.radius,
      this.color,
      this.boxDecoration,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
            width: width ?? double.infinity,
            child: Container(
              padding: margin ?? const EdgeInsets.all(0),
              height: height,
              decoration: boxDecoration ?? BoxDecoration(
                  borderRadius: BorderRadius.circular(radius ?? Dimensions.BORDER_RADIUS),
                  border: backgroundTransparent
                      ? Border.all(color: Theme.of(context).primaryColor)
                      : null,
                  color: color ?? (backgroundTransparent
                          ? Colors.transparent
                          : Theme.of(context).primaryColor)),
              child: MaterialButton(
                onPressed: onPressed,

                height: height,
                minWidth: width,
                // color: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.BORDER_RADIUS),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  icon != null
                      ? Icon(icon,
                          color: transparent
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).cardColor,
                        )
                      : const SizedBox(),
                  Text(buttonText,
                      textAlign: TextAlign.center,
                      style: poppinsSemiBold.copyWith(
                        color: textColor ??  (backgroundTransparent || transparent
                            ? Theme.of(context).primaryColor
                            : Colors.white),
                        fontSize: fontSize ?? 14,
                        fontWeight: FontWeight.w600,
                      )),
                ]),
              ),
            )));
  }
}
