import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/bloc/account/account_bloc.dart';
import 'package:mamo_app/bloc/account/account_event.dart';
import 'package:mamo_app/bloc/account/account_state.dart';
import 'package:mamo_app/bloc/profile/profile_bloc.dart';
import 'package:mamo_app/bloc/profile/profile_event.dart';
import 'package:mamo_app/bloc/profile/profile_state.dart';
import 'package:mamo_app/model/user_profile.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/screen_utils.dart';
import 'package:mamo_app/utils/utilities.dart';
import 'package:mamo_app/view/achievements_view.dart';
import 'package:mamo_app/view/profile/update_profile_view.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'package:mamo_app/widget/circle_avatar.dart';
import 'package:mamo_app/widget/common_appbar.dart';
import 'package:mamo_app/widget/global_cache.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  AccountBloc _accountBloc;
  ProfileBloc _profileBloc;

  @override
  void initState() {
    _accountBloc = BlocProvider.of<AccountBloc>(context);
    _accountBloc.add(AccountGetEvent());
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(ProfileGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state.status == AppConstants.STATUS_FAILURE) {
            Utilities.showToast(context, state.err);
          }
        },
        builder: (context, state) {
          UserProfile userInfo = state.userProfile;
          GlobalCache().loginData.fullName = userInfo.fullName;
          GlobalCache().loginData.email = userInfo.email;
          GlobalCache().loginData.gender = userInfo.gender;
          GlobalCache().loginData.avatarUrl = userInfo.avatarUrl;
          GlobalCache().loginData.birthday = userInfo.birthdayStr;
          GlobalCache().loginData.address = userInfo.address;
          GlobalCache().loginData.momoName = userInfo.momoName;
          GlobalCache().loginData.momoMobile = userInfo.momoMobile;
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: setHeight(200),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(getAssetsImage("bg_profile.png")),
                      fit: BoxFit.cover),
                ),
              ),
              Positioned(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: setHeight(160),
                    decoration: BoxDecoration(
                      // color: ColorUtils.colorTextLogo,
                      image: DecorationImage(
                        image: AssetImage(getAssetsImage("bg_profile.png")),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // color: ColorUtils.BG_ICOn,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            circleAvatar(GlobalCache()?.loginData?.avatarUrl,
                                GlobalCache()?.loginData?.fullName ?? ""),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                // onTap: () async {
                                //   List<Asset> resultList =
                                //   await MultiImagePicker.pickImages(
                                //       maxImages: 1,
                                //       enableCamera: true);
                                //   if (!mounted) return;
                                //   if (resultList.length > 0) {
                                //     var image = resultList.first;
                                //     upLoadImage(image);
                                //   }
                                // },
                                child: CircleAvatar(
                                    radius: setWidth(12),
                                    backgroundColor: ColorUtils.TEXT_PRICE,
                                    child: Image.asset(
                                        getAssetsIcon("cloud.png"))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: setHeight(5)),
                        Text(GlobalCache().loginData.fullName ?? "",
                            style: FontUtils.bold
                                .copyWith(color: ColorUtils.WHITE)),
                        Text(GlobalCache().loginData.userName,
                            style: FontUtils.medium.copyWith(
                                color: ColorUtils.WHITE, fontSize: setSp(12))),
                        SizedBox(
                          height: setHeight(8),
                        )
                      ],
                    ),
                  ),
                  BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state){
                      return GestureDetector(
                        onTap: (){
                          pushTo(context, AchievementsView());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width -
                              setWidth(16),
                          margin: EdgeInsets.only(right: setWidth(16), left: setWidth(16), bottom: setHeight(32)),
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: ColorUtils.WHITE,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorUtils.WHITE),
                            boxShadow: [
                              BoxShadow(
                                color: ColorUtils.gray.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text("Tổng thu nhập",    style: FontUtils.medium.copyWith(
                                      color: ColorUtils.TEXT_NAME,
                                      fontSize: setSp(12))),
                                  Text(Utilities.formatMoney(
                                      state.account == null ? 0 : state.account.totalBalance??0, suffix: 'đ'),
                                      style: FontUtils.bold.copyWith(
                                          color: ColorUtils.TEXT_PRICE)
                                  )
                                ],
                              ),
                              SizedBox(width: setWidth(60)),
                              Column(
                                children: [
                                  Text("Ví hiện có",    style: FontUtils.medium.copyWith(
                                      color: ColorUtils.TEXT_NAME,
                                      fontSize: setSp(12))),
                                  Text(Utilities.formatMoney(
                                     state.account == null ? 0 : state.account.balance??0 , suffix: 'đ'),
                                      style: FontUtils.bold.copyWith(
                                          color: ColorUtils.TEXT_PRICE))
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Text("Chi tiết",   style: FontUtils.medium.copyWith(
                                      color: ColorUtils.colorTextLogo)),
                                  Icon(Icons.arrow_forward_ios_outlined,   size: setSp(16),
                                    color: ColorUtils.colorTextLogo,)
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildItemMenu("Ngày sinh", "datebirth.png",
                          state.userProfile.birthdayStr ?? ""),
                      _buildItemMenu("Giới tính", "sex.png",
                          state.userProfile.gender ?? ""),
                      _buildItemMenu("Địa chỉ", "address.png",
                          state.userProfile.address ?? ""),
                      _buildItemMenu(
                          "Email", "email.png", state.userProfile.email ?? ""),
                      _buildItemMenu("SĐT momo", "phone.png",
                          state.userProfile.momoMobile ?? ""),
                      _buildItemMenu("Tên TK Momo", "logo_momo.png",
                          state.userProfile.momoName ?? ""),
                      Container(
                        margin: EdgeInsets.only(left: setWidth(16), top: setHeight(22), bottom: setHeight(22)),
                        child: GestureDetector(
                          onTap: () {
                            // Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                //     builder: (context) =>
                                //         ChangePasswordView()
                                // ));
                          },
                          child: Text(
                            "Đổi mật khẩu",
                            style: FontUtils.medium.copyWith(
                                color: ColorUtils.colorTextLogo),
                          ),
                        ),
                      ),
                    ],
                  )

                ],
              )),
              _custonAppBar(),
            ],
          );
        },
      ),
    );
  }
  _buildItemMenu(String name, String imageUrl, String lable) {
    return Container(
      margin: EdgeInsets.only(
          left: setWidth(16), right: setWidth(16)),
      padding: EdgeInsets.only(bottom: setHeight(14), top: setHeight(14)),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(width: 1, color: ColorUtils.underlined))),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.baseline,
        children: [
          Image.asset(getAssetsIcon(imageUrl),
              height: setHeight(19), width: setWidth(17)),
          SizedBox(width: setWidth(16)),
          Text(
            name,
            style: FontUtils.normal.copyWith(color: ColorUtils.TEXT_NAME),
          ),
          Spacer(),
          Container(
              width: setWidth(200),
              child: Text(lable, style: FontUtils.medium, overflow: TextOverflow.ellipsis,textAlign: TextAlign.right,))
        ],
      ),
    );
  }
  // upLoadImage(Asset asset) async {
  //   final filePath =
  //   await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
  //   if (filePath != null) {
  //     File file;
  //     if (filePath.toLowerCase().endsWith("heic")) {
  //       file = File(await HeicToJpg.convert(filePath));
  //     } else {
  //       file = File(filePath);
  //     }
  //
  //     var bufferFile = await Utilities.compress(
  //         file.path, await Utilities.getQuantity(file.path));
  //     if (bufferFile == null) {
  //       Utilities.showToast(context, "Có lỗi khi tải ảnh");
  //       return;
  //     }
  //     // // ignore: unrelated_type_equality_checks
  //     UploadImageBloc().uploadFileMultiPart(bufferFile, file).then(
  //           (response) async {
  //         if (response.data.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
  //           if (response.data.Data.length > 0) {
  //             String imgPath = await AppUtils.shared.pushWidgetValueReturn(
  //                 context, UpdateAvatar(response.data.Data[0]));
  //             if (imgPath != null && imgPath.isNotEmpty) {
  //               setState(() {});
  //             }
  //           }
  //         } else {
  //           Utilities.showToast(
  //               context,
  //               (response.data.ErrorMessage ?? "").isEmpty
  //                   ? response.data.ErrorCode
  //                   : response.data.ErrorMessage);
  //         }
  //       },
  //     );
  //   }
  // }
  Widget _custonAppBar() {
    return Container(
      padding: EdgeInsets.only(
          left: setWidth(15), right: setWidth(30), top: setHeight(30)),
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back_outlined,
                color: ColorUtils.WHITE,
                size: setSp(20),
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          Spacer(),
          InkWell(
              onTap: () async{
                final result = await pushTo(context, UpdateProfileView(), isReturn: true);
                if(result) {
                  _profileBloc.add(ProfileGetEvent());
                }
              },
              child: Image.asset(
                getAssetsIcon("editProfile.png"),
                width: setWidth(21),
                height: setHeight(19),
              ))
        ],
      ),
    );
  }
}
