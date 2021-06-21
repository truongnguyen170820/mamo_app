
import 'package:flutter/cupertino.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/utilities.dart';

Widget CustomItemShowMoney (String nameItem, num money, {Color colorName, Color colorMoney, Color colorBG}){
  return   Container(
    margin: EdgeInsets.only(
        top: setHeight(20),
        bottom: setHeight(16),
        right: setWidth(16),
        left: setWidth(16)),
    padding: EdgeInsets.only(
        left: setWidth(16),
        right: setWidth(19),
        top: setHeight(20),
        bottom: setHeight(19)),
    height: setHeight(65),
    decoration: BoxDecoration(
        color: colorBG ?? ColorUtils.colorStatus,
        borderRadius: BorderRadius.circular(16)),
    child: Row(
      children: [
        Text(nameItem,
            style: FontUtils.medium.copyWith(
                fontSize: setSp(13), color:colorName?? ColorUtils.colorTextLogo)),
        Spacer(),
        Text(
          Utilities.formatMoney(money, suffix: 'đ'),
          style: FontUtils.bold.copyWith(
              color: colorMoney ?? ColorUtils.TEXT_PRICE, fontSize: setSp(20)),
        )
      ],
    ),
  );
}