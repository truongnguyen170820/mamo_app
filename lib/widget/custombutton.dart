import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamo_app/utils/colors.dart';

class ButtonCustom extends StatelessWidget {
  String title;
  TextStyle textStyle;
  double borderRadius;
  Color bgColor;
  EdgeInsets margin;
  Function onTap;
  double width;
  double height;
  Color colorShadow;
  Border colorBorder;


  ButtonCustom(
      {this.bgColor = ColorConstants.colorTextLogo,
      this.onTap,
      this.title,
      this.borderRadius = 27,
      this.textStyle,
      this.margin,
      this.width = double.infinity,
      this.height = 54,
      this.colorShadow,
        this.colorBorder,

      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: width, height: height,
        alignment: Alignment.center,
        // padding:  EdgeInsets.only(left:setWidth(20), top:setHeight(15), right:setWidth(20), bottom: setHeight(15)),
        decoration: BoxDecoration(
          border: colorBorder == null ? null : Border.all(width: 2.0, color: Colors.black),
            color: bgColor, borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: colorShadow == null ? null : [
              BoxShadow(offset: Offset(0,3), blurRadius: 3, color: colorShadow),
        ]),
        child: Text(
          title,
          style: textStyle,
        ),
      ),
    );
  }
}
