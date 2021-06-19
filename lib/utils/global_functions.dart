import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mamo_app/utils/animation_pushto.dart';

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
pushTo(BuildContext context,Widget widget,{bool isReturn=false} )async{
  dynamic result;
  if(isReturn)result=await Navigator.push(context, SlideRightRoute(page: widget,),);
  else result = Navigator.push(context, SlideRightRoute(page: widget,),);
  return  result;
}
