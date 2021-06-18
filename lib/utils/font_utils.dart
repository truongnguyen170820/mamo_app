
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:mamo_app/utils/colors.dart';
import 'package:mamo_app/utils/global_functions.dart';

class FontUtils {
  static TextStyle normal = GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: setSp(14),
    color: ColorConstants.TEXT_NORMAL,
  );

  static TextStyle bold = GoogleFonts.roboto(
    fontWeight: FontWeight.bold,
    fontSize: setSp(14),
    color: ColorConstants.TEXT_NORMAL,
  );

  static TextStyle medium = GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: setSp(14),
    color: ColorConstants.TEXT_NORMAL,
  );

  static TextStyle semibold = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    color: ColorConstants.TEXT_NORMAL,
    fontSize: setSp(14),
  );
}
