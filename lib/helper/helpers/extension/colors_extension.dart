import 'package:flutter/material.dart';

extension GtdColors on Colors {
  static Color appMainColor(BuildContext context) => Theme.of(context).colorScheme.primary;

  static Color winterWhite = const Color(0xFFf9fafb);
  static Color steelGrey = const Color(0xFF6c727f);
  static Color cloudyGrey = const Color(0xFFe5e7ea);
  static Color inkBlack = const Color(0xFF121826);
  static Color blueGrey = const Color(0xFFE5E7EB);
  static Color slateGrey = const Color(0xFF9398A3);
  static Color crimsonRed = const Color(0xFFDB0D0D);
  static Color snowGrey = const Color(0xFFF3F4F6);
  static Color stormGray = const Color(0xFFB4BAC4);
  static Color whiteWash = const Color(0xFFF5F5F5);
  static Color pumpkinOrange = const Color(0xFFF47920);
  static Color amber = const Color(0xFFFBB21B);
  static Color emerald = const Color(0xFF1AA260);

  static LinearGradient appGradient(BuildContext context) => LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: const [0.1, 1],
        colors: [emerald, pumpkinOrange],
      );
}
