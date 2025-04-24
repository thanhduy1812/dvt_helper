import 'package:flutter/material.dart';

class GtdGradientIcon extends StatelessWidget {
  const GtdGradientIcon({required this.icon, this.size, required this.gradient, super.key});

  final IconData icon;
  final double? size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return gradient.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: SizedBox(
        width: size,
        height: size,
        child: Icon(
          icon,
          size: size,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}

class GtdGradientSvg extends StatelessWidget {
  const GtdGradientSvg({required this.image, this.width, this.height, required this.gradient, super.key});

  final Widget image;
  final double? width;
  final double? height;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        // final Rect rect = Rect.fromLTRB(0, 0, width, height);
        return gradient.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: SizedBox(
        width: width,
        height: height,
        child: image,
      ),
    );
  }
}

class GtdGradientImage extends StatelessWidget {
  const GtdGradientImage({required this.image, this.width, this.height, required this.gradient, super.key});

  final Image image;
  final double? width;
  final double? height;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        // final Rect rect = Rect.fromLTRB(0, 0, width, height);
        return gradient.createShader(bounds);
      },
      blendMode: BlendMode.srcIn,
      child: image,
    );
  }
}
