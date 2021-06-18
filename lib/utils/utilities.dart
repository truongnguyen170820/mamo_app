
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mamo_app/api/api_constants.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'font_utils.dart';

class Utilities {
  static DateFormat dayFormat = new DateFormat('dd/MM/yyyy HH:mm:ss');

  static showToast(BuildContext context, String msg) {
    FlutterToast fToast = FlutterToast(context);

    var toast = Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          color: Colors.black54,
        ),
        child:
            Text(msg, style: FontUtils.normal.copyWith(color: Colors.white)));

    fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: AppConstants.TOAST_DURATION),
      gravity: ToastGravity.BOTTOM,
    );
  }

  static String dateTimeToString(DateTime date, {String format: "dd/MM/yyyy"}) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(date);
  }

  static String formatNumber(dynamic number, {String format = "#0.00"}) {
    return NumberFormat(format).format(number);
  }

  static String formatMoney(dynamic number, {String suffix = "VND"}) {
    final oCcy = NumberFormat("#,##0", "vi_VN");
    return oCcy.format(number) + suffix;
  }

  static getRandomNumber(String text, int number) {
    if (text == null || text.isEmpty) return Random().nextInt(number);
    return utf8.encode(text).fold(0, (result, item) => result + item) % number;
  }

  static String getTimeDiff({String time}) {
    var timeDiff = DateTime.now().difference(dayFormat.parse(time));
    if (timeDiff.inMinutes >= 60) {
      if (timeDiff.inHours >= 24) {
        return "${timeDiff.inDays} ngày trước";
      } else {
        return "${timeDiff.inHours} giờ trước";
      }
    } else if (timeDiff.inMinutes <= 0) {
      return "${timeDiff.inSeconds ?? ""} giây trước";
    } else {
      return "${timeDiff.inMinutes ?? ""} phút trước";
    }
  }

  static String getReadType(num readType) {
    return readType == AppConstants.READ_TYPE_BOOK
        ? "đọc truyện"
        : (readType == AppConstants.READ_TYPE_NEWS
            ? "đọc báo"
            : (readType == AppConstants.READ_TYPE_VIDEO ? "xem video" : ""));
  }

  static String getAcronym(String text) {
    if (text == null || text.isEmpty) return "";
    var words = text.trim().split(' ');
    if (words.length == 1) {
      if (words[0].length == 1) return words[0];
      return words[0].substring(0, 2);
    }
    var first = words.first;
    var last = words.last;
    return first.substring(0, 1) + last.substring(0, 1);
  }

  static String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat("HH:mm"); //"6:00 AM"
    return format.format(dt);
  }

  static String getFullImagePath(String url) {
    if (url == null || url.isEmpty) return "";
    if (url.startsWith("http://")) return url;
    return ApiConstants.BASE_IMAGE_URL + url;
  }
}
