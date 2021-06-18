
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamo_app/utils/colors.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
class TextStyles {
  static final TextStyle kBold18MoneyStyle = FontUtils.bold.copyWith(
    fontSize: setSp(18),
    color: ColorConstants.MONEY_COLOR,
  );

  static final TextStyle kMedium16Primary = FontUtils.medium.copyWith(
    fontSize: setSp(16),
    color: ColorConstants.PRIMARY_COLOR,
  );

  static final TextStyle kMedium16 = FontUtils.medium.copyWith(
    fontSize: setSp(16),
  );

  static final TextStyle kBold16 = FontUtils.bold.copyWith(
    fontSize: setSp(16),
  );

  static final TextStyle kTabTitleStyle = FontUtils.medium.copyWith(
    fontSize: setSp(15),
  );

  static final TextStyle kRegular14PrimaryStyle = FontUtils.medium.copyWith(
    fontSize: setSp(14),
    color: ColorConstants.PRIMARY_COLOR,
  );

  static final TextStyle kHintStyle = FontUtils.normal.copyWith(
    fontSize: setSp(14),
    color: ColorConstants.BORDER_COLOR,
  );

  static final TextStyle kRegular12Tiny = FontUtils.normal.copyWith(
    fontSize: setSp(12),
    color: ColorConstants.TINY_TEXT,
  );

  static final TextStyle kTimeDiffStyle =
      kRegular12Tiny.copyWith(fontStyle: FontStyle.italic);

  static final TextStyle kMedium13 = FontUtils.medium.copyWith(
    fontSize: setSp(13),
  );

  static final TextStyle kMedium12 = FontUtils.medium.copyWith(
    fontSize: setSp(12),
    color: ColorConstants.TEXT_NORMAL,
  );

  static final TextStyle kBold12 = FontUtils.bold.copyWith(
    fontSize: setSp(12),
  );

  static final TextStyle kMedium10White = FontUtils.medium.copyWith(
    fontSize: setSp(10),
    color: Colors.white,
  );
  //Singleton factory
  static final TextStyles _instance = TextStyles._internal();

  factory TextStyles() {
    return _instance;
  }

  TextStyles._internal();
}
