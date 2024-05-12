import 'package:cached_network_image/cached_network_image.dart';
import 'package:dvt_helper/helper/helper.dart';
import 'package:dvt_helper/helper/helpers/extension/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

extension DVTImage on Image {
  static Image imgFromSupplier(
      {required String assetName, required String packageName, double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      GtdString.pathForAsset(packageName, assetName),
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget svgFromAsset(
      {required String assetPath, double? width, double? height, BoxFit fit = BoxFit.contain, Color? color}) {
    return SvgPicture.asset(
      assetPath,
      width: width,
      height: height,
      fit: fit,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Widget svgFromSupplier(
      {required String assetName,
      required String packageName,
      double? width,
      double? height,
      BoxFit fit = BoxFit.contain,
      Color? color}) {
    return SvgPicture.asset(
      GtdString.pathForAsset(packageName, assetName),
      width: width,
      height: height,
      fit: fit,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Image imgFromCommon(
      {required String assetName, required String packageName, double? width, double? height, BoxFit? fit}) {
    return Image.asset(
      GtdString.pathForAsset(packageName, assetName),
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget svgFromCommon(
      {required String assetName,
      required String packageName,
      double? width,
      double? height,
      BoxFit fit = BoxFit.contain,
      Color? color}) {
    return SvgPicture.asset(
      GtdString.pathForAsset(packageName, assetName),
      width: width,
      height: height,
      fit: fit,
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );
  }

  static Image giftFromSupplier({required String assetName, required String packageName, BoxFit? boxFit}) {
    return Image.asset(
      GtdString.pathForAsset(packageName, assetName),
      gaplessPlayback: true,
      fit: boxFit,
    );
  }

  static Image giftFromCommon({required String assetName, required String packageName, BoxFit? boxFit}) {
    return Image.asset(
      GtdString.pathForAsset(packageName, assetName),
      gaplessPlayback: true,
      fit: boxFit,
    );
  }

  static Image imgFromUrl(String url, {BoxFit boxFit = BoxFit.fitWidth}) {
    var img = Image.network(
      url,
      fit: boxFit,
    );
    return img;
  }

  static Widget svgFromUrl(String url, {BoxFit boxFit = BoxFit.fitWidth}) {
    var img = SvgPicture.network(
      url,
      fit: boxFit,
    );
    return img;
  }

  static Widget cachedImgFromUrl(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  static Widget cachedImgUrlWithPlaceholder({
    required String url,
    Widget? placeholder,
    Widget? errorWidget,
    BoxFit? fit,
  }) {
    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          Container(
            width: 270,
            height: 90,
            color: Colors.white,
          ),
      errorWidget: (context, url, error) => errorWidget ?? const Icon(Icons.error),
    );
  }

  // static Image imgFromAsset({required String pathResource, double? width, double? height, BoxFit? fit, Color? color}) {
  //   return Image.asset(
  //     pathResource,
  //     width: width,
  //     height: height,
  //     color: color,
  //     fit: fit,
  //   );
  // }

  // static Widget svgFromAsset(
  //     {required String pathResource, double? width, double? height, BoxFit fit = BoxFit.contain, Color? color}) {
  //   return SvgPicture.asset(
  //     pathResource,
  //     width: width,
  //     height: height,
  //     fit: fit,
  //     colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
  //   );
  // }

  //MARK: Using for Lottie Json from Adobe Effect or network
  static Widget assetAnimated(
      {required String assetName,
      required String packageName,
      double? width,
      double? height,
      BoxFit? fit,
      AnimationController? controller,
      bool? repeat,
      bool? reverse}) {
    return Lottie.asset(GtdString.pathForAsset(packageName, assetName),
        controller: controller, repeat: repeat, reverse: reverse, width: width, height: height, fit: fit);
  }

  static Widget lottieImage(
      {required String assetName,
      double? width,
      double? height,
      BoxFit? fit,
      AnimationController? controller,
      bool? repeat,
      bool? reverse}) {
    return Lottie.asset(assetName,
        controller: controller, repeat: repeat, reverse: reverse, width: width, height: height, fit: fit);
  }

  static Widget networkAnimated(
      {required String assetName,
      required String packageName,
      double? width,
      double? height,
      BoxFit? fit,
      AnimationController? controller,
      bool? repeat,
      bool? reverse}) {
    return Lottie.network(GtdString.pathForAsset(packageName, assetName),
        controller: controller, repeat: repeat, reverse: reverse, fit: fit, width: width, height: height);
  }
}
