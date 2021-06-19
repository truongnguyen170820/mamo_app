import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mamo_app/bloc/profile/update_profile/update_profile_bloc.dart';
import 'package:mamo_app/bloc/profile/update_profile/update_profile_event.dart';
import 'package:mamo_app/bloc/profile/update_profile/update_profile_state.dart';
import 'package:mamo_app/model/update_profile_request.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/text_styles.dart';
import 'package:mamo_app/utils/utilities.dart';
import 'package:mamo_app/utils/validators.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'package:mamo_app/widget/common_appbar.dart';
import 'package:mamo_app/widget/custombutton.dart';
import 'package:mamo_app/widget/global_cache.dart';

class UpdateProfileView extends StatefulWidget {
  @override
  _UpdateProfileViewState createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtEmail = TextEditingController();
  TextEditingController _txtBirthdayStr = TextEditingController();
  TextEditingController _txtAddress = TextEditingController();
  TextEditingController _txtMomoMobile = TextEditingController();
  TextEditingController _txtMomoName = TextEditingController();
  String _radioValue;
  UpdateProfileBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<UpdateProfileBloc>(context);
    bloc.add(UpdateProfileSubmitedEvent());
    var userInfo = GlobalCache().loginData;
    _txtName.text = userInfo.fullName;
    _txtEmail.text = userInfo.email;
    _txtBirthdayStr.text = userInfo.birthday;
    _txtAddress.text = userInfo.address;
    _txtMomoMobile.text = userInfo.momoMobile;
    _txtMomoName.text = userInfo.momoName;
    if (userInfo.gender != null && userInfo.gender.isNotEmpty)
      _radioValue = userInfo.gender;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(
        context,
        "Chỉnh sửa thông tin",
      ),
      body: BlocListener<UpdateProfileBloc, UpdateProfileState>(
        listener: (context, state){
          if(state.status == AppConstants.STATUS_SUCCESS){
            Navigator.pop(context, true);
            // Navigator.pop(context);
          }
          if (state.status == AppConstants.STATUS_FAILURE) {
            Utilities.showToast(context, state.err);
          }
        },
        child: BlocBuilder<UpdateProfileBloc, UpdateProfileState>(
          builder: (context, state) => GestureDetector(
            onTap: () {
              dismissKeyboard(context);
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildItemInfor(_txtName, "Họ tên", "Nhập họ tên"),
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: <Widget>[
                      _buildItemInfor(_txtBirthdayStr, "Ngày sinh", "Chọn ngày sinh"),
                      Positioned(
                        bottom: setHeight(35),
                        right: setWidth(25),
                        child: InkWell(
                          onTap: () {
                            _selectDate(context, _txtBirthdayStr);
                          },
                          child: Image.asset(
                            getAssetsIcon("datebirth.png"),
                            height: setHeight(19),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: setWidth(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Giới tính',
                            style: FontUtils.normal.copyWith(
                                fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
                        Row(
                          children: <Widget>[
                            Container(
                              // alignment: Alignment.centerRight,
                              child: Radio(
                                  activeColor: ColorUtils.BG_ICOn,
                                  value: 'Nam',
                                  groupValue: _radioValue,
                                  onChanged: (value) {
                                    setState(() {
                                      _radioValue = value;
                                    });
                                  }),
                            ),
                            Text('Nam', style: FontUtils.medium),
                            Radio(
                                activeColor: ColorUtils.BG_ICOn,
                                value: 'Nữ',
                                groupValue: _radioValue,
                                onChanged: (value) {
                                  setState(() {
                                    _radioValue = value;
                                  });
                                }),
                            Text('Nữ', style: FontUtils.medium)
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildItemInfor(_txtAddress, "Địa chỉ", "Nhập địa chỉ"),
                  _buildItemInfor(_txtEmail, "Email", "Nhập Email"),
                  _buildItemInfor(_txtMomoMobile, "SĐT Momo", "Nhập SĐT"),
                  _buildItemInfor(
                      _txtMomoName, "Tên tài khoản Momo", "Nhập tài khoản Momo"),
                  ButtonCustom(
                    height: setHeight(45),
                    width: setWidth(220),
                    bgColor: ColorUtils.colorTextLogo,
                    borderRadius: 12,
                    title: "Cập nhật",
                    onTap: () {updateProfile();},
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void updateProfile() {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_txtName.text.trim().isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập họ và tên');
      return;
    }
    if (_radioValue == null || _radioValue.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa chọn giới tính');
      return;
    }
    if (_txtAddress.text.trim().isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập địa chỉ');
      return;
    }
    if (_txtEmail.text.isEmpty) {
      Utilities.showToast(context, 'Bạn chưa nhập email');
      return;
    }
    if (!Validator.instance.IsEmail(_txtEmail.text)) {
      Utilities.showToast(context, 'Email không hợp lệ');
      return;
    }
      BlocProvider.of<UpdateProfileBloc>(context).add(UpdateProfileSubmitedEvent(
        fullName: _txtName.text,
        address: _txtAddress.text,
        gender: _radioValue,
        birthdayStr: _txtBirthdayStr.text,
        email: _txtEmail.text,
        momoMobile: _txtMomoMobile.text,
        momoName: _txtMomoName.text,
      ));
  }

  Future<Null> _selectDate(
      BuildContext context, TextEditingController txtController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        DateFormat('dd/MM/yyyy').format(picked) != txtController.text)
      setState(() {
        // selectedDate = picked;
        txtController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
  }

  Widget _buildItemInfor(TextEditingController controller, String nameInfo, String hintInfor) {
    return Container(
      margin: EdgeInsets.only(
          left: setWidth(16),
          right: setWidth(16),
          bottom: setHeight(16),
          top: setHeight(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nameInfo,
              style: FontUtils.normal
                  .copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
          Container(
            margin: EdgeInsets.only(top: setHeight(8)),
            padding: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
                color: ColorUtils.underlined,
                border: Border.all(width: 1, color: ColorUtils.gray6),
                borderRadius: BorderRadius.circular(8)),
            child: TextField(
              controller: controller,
              style: FontUtils.medium.copyWith(color: ColorUtils.NUMBER_PAGE),
              textAlign: TextAlign.start,
              // textAlignVertical: TextAlignVertical.center,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                hintText: hintInfor,
                border: InputBorder.none,
                hintStyle: TextStyles.hint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
