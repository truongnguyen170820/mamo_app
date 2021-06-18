import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

num setHeight(num num) {
  return ScreenUtil().setHeight(num);
}

num setWidth(num num) {
  return ScreenUtil().setWidth(num);
}

num setSp(num num) {
  return ScreenUtil().setSp(num);
}

void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

String getAssetsIcon(String icon){
  return "assets/icons/" + icon;
}

String getAssetsImage(String image){
  return "assets/images/" + image;
}
