import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/bloc/login/login_bloc.dart';
import 'package:mamo_app/bloc/login/login_event.dart';
import 'package:mamo_app/bloc/login/login_state.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/utilities.dart';
import 'package:mamo_app/view/home/home_view_page.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'package:mamo_app/widget/custom_textfield.dart';
import 'package:mamo_app/widget/custombutton.dart';

class LoginViewPage extends StatefulWidget {
  const LoginViewPage({Key key}) : super(key: key);
  @override
  _LoginViewPageState createState() => _LoginViewPageState();
}

class _LoginViewPageState extends State<LoginViewPage> {
  TextEditingController _userCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  // ProgressDialog _progressDialog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state){
          if(state.status == AppConstants.STATUS_SUCCESS){
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => HomeViewPage()),
                    (route) => false);
          }
          if (state.status == AppConstants.STATUS_FAILURE) {
            Utilities.showToast(context, state.err);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) => GestureDetector(
            onTap: (){
              dismissKeyboard(context);
            },
            child: Container(
              color: Colors.grey,
              child: Column(
                children: [
                  SizedBox(height: setHeight(100)),
                  CustomTextFormField(
                    controller: _userCtrl,
                    hintText: "Nhập tên tài khoản",
                    textInputAction: TextInputAction.next,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(13),
                      child: Image.asset(getAssetsIcon("ic_user.png")),
                    ),
                  ),
                  CustomTextFormField(
                    controller: _passwordCtrl,
                    hintText: "Nhập tên password",
                    textInputAction: TextInputAction.next,
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(13),
                      child: Image.asset(getAssetsIcon("key.png")),
                    ),
                  ),
                  ButtonCustom(
                    height: setHeight(45),
                    width: setWidth(200),
                    title: "Đăng nhập",
                    onTap: (){_loginSubmitted(context);
                    },
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
  void _loginSubmitted(BuildContext context) {
    if (_userCtrl.text.isEmpty) {
      Utilities.showToast(context, 'Tên đăng nhập không được để trống');
    } else if (_passwordCtrl.text.length < 6) {
      Utilities.showToast(
          context, 'Mật khẩu không được để trống và phải có ít nhất 6 kí tự');
    } else {
      BlocProvider.of<LoginBloc>(context).add(
        LoginSubmittedEvent(
          userName: _userCtrl.text.trim(),
          password: _passwordCtrl.text.trim(),
        ),
      );
    }
  }
}
