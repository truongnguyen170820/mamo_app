
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mamo_app/utils/colors.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key key,
    this.hintText,
    this.prefixIcon,
    this.obscureText,
    this.controller,
    this.height,
    this.suffixIcon,
    this.textInputAction,
    this.color,
    this.keyboardType,
    this.onChanged,
  }) : super(key: key);

  final String hintText;
  final Widget prefixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final num height;
  final Widget suffixIcon;
  final TextInputAction textInputAction;
  final Color color;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: setHeight(height ?? 45),
      decoration: BoxDecoration(
        color: color ?? Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstants.BORDER_COLOR),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: TextFormField(
              style: FontUtils.medium,
              keyboardType: keyboardType ?? TextInputType.text,
              textInputAction: textInputAction ?? TextInputAction.done,
              controller: controller,
              obscureText: obscureText ?? false,
              onChanged: onChanged ?? (value) {},
              decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: color == null
                      ? TextStyles.kHintStyle
                      : TextStyles.kHintStyle.copyWith(
                          color: Colors.grey.withOpacity(0.7)),
                  contentPadding: EdgeInsets.only(
                    bottom: setHeight(height ?? 45) / 2,
                    left: setWidth((prefixIcon == null) ? 20 : 0),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: prefixIcon),
            ),
          ),
          suffixIcon == null
              ? Container()
              : Expanded(
                  child: suffixIcon,
                  flex: 1,
                ),
        ],
      ),
    );
  }
}
