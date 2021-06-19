import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/bloc/account/account_bloc.dart';
import 'package:mamo_app/bloc/account/account_state.dart';
import 'package:mamo_app/model/login_data.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/utilities.dart';
import 'package:mamo_app/widget/common_appbar.dart';
import 'package:mamo_app/widget/custombutton.dart';

class AchievementsView extends StatefulWidget {
  @override
  _AchievementsViewState createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, "Bảng thành tích"),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state){
          return Column(
            children: [
              _buildBodyAchievement(account: state.account),
              _buildWithdrawal()
            ],
          );
        },
      ),
    );
  }

  Widget _buildBodyAchievement({Account account}){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: setHeight(20), bottom: setHeight(16), right: setWidth(16), left: setWidth(16)),
          padding: EdgeInsets.only(left: setWidth(16), right: setWidth(19),top: setHeight(20), bottom: setHeight(19)),
          height: setHeight(65),
          decoration: BoxDecoration(
              color: ColorUtils.BG_ICOn,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            children: [
              Text("Tổng thu nhập", style: FontUtils.medium.copyWith(fontSize: setSp(13), color: ColorUtils.colorStatus)),
              Spacer(),
              Text(Utilities.formatMoney(account.totalBalance, suffix: 'đ'), style: FontUtils.bold.copyWith(color: ColorUtils.colorStatus, fontSize: setSp(20)),)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemRead("readbook.png", "Đọc truyện", account.totalBalanceReadStory),
            _itemRead("news.png", "Đọc báo", account.totalBalanceReadNews),
          ],
        ),
        SizedBox(height: setHeight(15),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemRead("video.png", "Xem video", account.totalBalanceViewVideo),
            _itemRead("hoahong.png", "Hoa hồng", account.totalBalanceAffiliate)
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: setHeight(20), bottom: setHeight(16), right: setWidth(16), left: setWidth(16)),
          padding: EdgeInsets.only(left: setWidth(16), right: setWidth(19),top: setHeight(20), bottom: setHeight(19)),
          height: setHeight(65),
          decoration: BoxDecoration(
              color: ColorUtils.colorStatus,
              borderRadius: BorderRadius.circular(16)
          ),
          child: Row(
            children: [
              Text("Ví hiện có", style: FontUtils.medium.copyWith(fontSize: setSp(13), color: ColorUtils.colorTextLogo)),
              Spacer(),
              Text(Utilities.formatMoney(account.balance, suffix: 'đ'), style: FontUtils.bold.copyWith(color: ColorUtils.TEXT_PRICE, fontSize: setSp(20)),)
            ],
          ),
        ),
      ],
    );
  }
  Widget _itemRead(String imageUrl, String nameRead, num money){
    return Container(
      height: setHeight(68),
      width: setWidth(165),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorUtils.underlined, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(left: setWidth(16)),
              padding: EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: ColorUtils.colorStatus,
                  borderRadius: BorderRadius.circular(12)
              ),
              child: Image.asset(getAssetsIcon(imageUrl), color: ColorUtils.BG_ICOn,width: setWidth(20),height: setHeight(20),)
          ),
          SizedBox(width: setWidth(8)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nameRead, style: FontUtils.medium.copyWith(fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
              Text(Utilities.formatMoney(money, suffix: 'đ'), style: FontUtils.bold.copyWith(color: ColorUtils.NUMBER_PAGE)),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildWithdrawal(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ButtonCustom(
          height: setHeight(45),
          width: setWidth(160),
          borderRadius: 12,
          title: "RÚT MOMO",
          textStyle: FontUtils.medium.copyWith(color: ColorUtils.WHITE),
          bgColor: ColorUtils.TEXT_PRICE,
          onTap: (){},
        ),
        ButtonCustom(
          height: setHeight(45),
          width: setWidth(160),
          borderRadius: 12,
          title: "RÚT THẺ ĐT",
          textStyle: FontUtils.medium.copyWith(color: ColorUtils.WHITE),
          bgColor: ColorUtils.colorTextLogo,
          onTap: (){},
        )
      ],
    );
  }
  Widget _buildHistoryWithdrawal(){
    return Column();
  }
}
