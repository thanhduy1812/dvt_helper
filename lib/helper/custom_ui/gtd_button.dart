library gtd_button;

import 'package:flutter/material.dart';
import 'package:gtd_helper/helper/helper.dart';


class GtdButton extends StatelessWidget {
  final GtdVoidCallback? onPressed;
  final String? text;
  final double? height;
  final double? width;
  final double? elevation;
  final Color? colorText;
  final double? fontSize;
  final Widget? trailingIcon;
  final Widget? leadingIcon;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final Gradient? gradient;
  final BorderSide? borderSide;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final String? tooltip;
  final bool isEnable;

  const GtdButton({
    super.key,
    this.onPressed,
    this.text,
    this.height,
    this.width,
    this.colorText,
    this.trailingIcon,
    this.leadingIcon,
    this.borderRadius,
    this.fontWeight,
    this.gradient,
    this.color,
    this.borderSide,
    this.padding,
    this.fontSize,
    this.isEnable = true,
    this.elevation,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Tooltip(
        message: tooltip ?? "",
        child: ElevatedButton(
          onPressed: isEnable ? onPressed : null, // Disables the button if `isEnable` is false

          style: ElevatedButton.styleFrom(
            padding: padding ?? EdgeInsets.zero,

            minimumSize: Size(width ?? 0, height ?? 32),
            backgroundColor: isEnable ? color : (color ?? Colors.blueAccent).withOpacity(0.4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6)),
              side: borderSide ?? BorderSide.none,
            ),
            elevation: elevation ?? 0, // Remove elevation if you want a flat button
            textStyle: TextStyle(
              color: colorText ?? Colors.white,
              fontWeight: fontWeight ?? FontWeight.w600,
              fontSize: fontSize ?? 13,
            ),
          ),
          child: FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingIcon != null) Center(child: leadingIcon!),
                if ((text ?? "").isNotEmpty)
                  Text(
                    text!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: colorText ?? Colors.white,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      fontSize: fontSize ?? 13,
                    ),
                  ),
                if (trailingIcon != null) trailingIcon!
              ].divide(const SizedBox(width: 4)),
            ),
          ),
        ),
      ),
    );
  }
}

// class GtdIconButton extends StatelessWidget {
//   final GtdVoidCallback? onPressed;
//   final double? size;
//   final Widget icon;
//   final Widget? selectedIcon;
//   final double? borderRadius;
//   final FontWeight? fontWeight;
//   final Gradient? gradient;
//   final BorderSide? borderSide;
//   final Color? color;
//   final Color? disableColor;
//   final EdgeInsetsGeometry? padding;
//   final String? toolTip;
//   final bool isSelected;

//   const GtdIconButton({
//     super.key,
//     this.onPressed,
//     this.size,
//     required this.icon,
//     this.borderRadius,
//     this.fontWeight,
//     this.gradient,
//     this.color,
//     this.borderSide,
//     this.padding,
//     this.isSelected = false,
//     this.selectedIcon,
//     this.toolTip,
//     this.disableColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     double size = this.size ?? 32;
//     return IconButton(
//       color: context.appTheme.primary,
//       iconSize: size,
//       constraints: BoxConstraints.tightFor(width: size, height: size),
//       style: IconButton.styleFrom(
//           backgroundColor: color ?? context.appTheme.primary,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 8))),
//       onPressed: onPressed,
//       icon: icon,
//     );
//   }
// }
