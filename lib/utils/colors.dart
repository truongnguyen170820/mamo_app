import 'package:flutter/material.dart';

class ColorConstants {
  // static const primaryColor = Color(0xFF3ac5c9);
  static const secondaryColor = Color(0xFF7b60c4);
  static const accentShadeColor = Color(0xFF58458c);
  static const darkShadeColor = Color(0xFF25164d);
  static const borderColor = Color(0xFFd3d1d1);
  static const backgroundColor = Color(0xFFFFFFFF);
  static const dividerColor = Colors.black12;
  static const colorTextLogo = Color(0xFF12AB69);
  //
  // static const primaryGradientColor = LinearGradient(
  //   begin: Alignment.topCenter,
  //   end: Alignment.bottomCenter,
  //   colors: [PRIMARY_COLOR, secondaryColor],
  // );

  static const BoxShadow TAB_SHADOW = BoxShadow(
    color: TAB_SHADOW_COLOR,
    blurRadius: 15,
    offset: Offset(0, 8),
  );

  static const BoxShadow INCOMING_SHADOW = BoxShadow(
    color: INCOMING_MONEY_SHADOW_COLOR,
    blurRadius: 8,
    offset: Offset(0, 3),
  );

  static const Color INCOMING_MONEY_SHADOW_COLOR = Color(0xFFE0E0E0);
  static const Color TAB_SHADOW_COLOR = Color(0xFFF7F7F8);
  static const Color TEXT_NORMAL = Color(0xFF131414);
  static const Color PRIMARY_COLOR = Color(0xFF12AB69);
  static const Color BACK_GROUND_PRIMARY = Color(0xFFE2FFEB);
  static const Color BORDER_COLOR = Color(0xFFDDE2E4);
  static const Color CARD_BORDER = Color(0xFFEBF0F8);
  static const Color TINY_TEXT = Color(0xFF7F8591);
  static const Color NOTIFY_BACKGROUND = Color(0xFFFFD9D9);
  static const Color NOTIFY_COLOR = Color(0xFFF93333);
  static const Color MONEY_COLOR = Color(0xFfF9B033);

  static const DEFAULT_AVATAR_COLOR = [
    Color(0xFFF29496),
    Color(0xFFF294E8),
    Color(0xFFAD96F8),
    Color(0xFF96B4F9),
    Color(0xFF91E5FC),
    Color(0xFF7FE292),
    Color(0xFF20C9FF)
  ];

  ///Singleton factory
  static final ColorConstants _instance = ColorConstants._internal();

  factory ColorConstants() {
    return _instance;
  }

  ColorConstants._internal();
}
