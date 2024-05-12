import 'package:flutter/material.dart';

extension DVTBuildContext on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);
}
