import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/bloc/account/account_bloc.dart';
import 'package:mamo_app/bloc/account/account_state.dart';
import 'package:mamo_app/bloc/achievements/history_transaction/history_transaction_bloc.dart';
import 'package:mamo_app/bloc/achievements/history_transaction/history_transaction_event.dart';
import 'package:mamo_app/bloc/achievements/history_transaction/history_transaction_state.dart';
import 'package:mamo_app/model/login_data.dart';
import 'package:mamo_app/model/transaction_history_model.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/utilities.dart';
import 'package:mamo_app/view/achievements/draw_card_view.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'package:mamo_app/widget/common_appbar.dart';
import 'package:mamo_app/widget/custombutton.dart';
import 'package:mamo_app/widget/global_cache.dart';
import 'package:mamo_app/widget/item_show_money.dart';

class AchievementsView extends StatefulWidget {
  @override
  _AchievementsViewState createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  HistoryTransactionBloc bloc;
  int payType = 1;
  @override
  void initState() {
    bloc = BlocProvider.of<HistoryTransactionBloc>(context);
    bloc.add(HistoryTranscationStartedEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, "Bảng thành tích"),
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          return Column(
            children: [
              _buildBodyAchievement(account: state.account),
              _buildWithdrawal(),
              _buildHistoryTranscation(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBodyAchievement({Account account}) {
    return Column(
      children: [
        CustomItemShowMoney("Tổng thu nhập", account.totalBalance,
            colorBG: ColorUtils.colorTextLogo,
            colorMoney: ColorUtils.WHITE,
            colorName: ColorUtils.WHITE),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemRead(
                "readbook.png", "Đọc truyện", account.totalBalanceReadStory),
            _itemRead("news.png", "Đọc báo", account.totalBalanceReadNews),
          ],
        ),
        SizedBox(
          height: setHeight(15),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _itemRead("video.png", "Xem video", account.totalBalanceViewVideo),
            _itemRead("hoahong.png", "Hoa hồng", account.totalBalanceAffiliate)
          ],
        ),
        CustomItemShowMoney("Ví hiện có", account.balance)
      ],
    );
  }
  Widget _itemRead(String imageUrl, String nameRead, num money) {
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
                  borderRadius: BorderRadius.circular(12)),
              child: Image.asset(
                getAssetsIcon(imageUrl),
                color: ColorUtils.BG_ICOn,
                width: setWidth(20),
                height: setHeight(20),
              )),
          SizedBox(width: setWidth(8)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nameRead,
                  style: FontUtils.medium.copyWith(
                      fontSize: setSp(12), color: ColorUtils.TEXT_NAME)),
              Text(Utilities.formatMoney(money, suffix: 'đ'),
                  style:
                      FontUtils.bold.copyWith(color: ColorUtils.NUMBER_PAGE)),
            ],
          )
        ],
      ),
    );
  }
  Widget _buildWithdrawal() {
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
          onTap: () {
            pushTo(context, DrawCardView(type: payType,balance: GlobalCache().loginData.account.balance,));
          },
        ),
        ButtonCustom(
          height: setHeight(45),
          width: setWidth(160),
          borderRadius: 12,
          title: "RÚT THẺ ĐT",
          textStyle: FontUtils.medium.copyWith(color: ColorUtils.WHITE),
          bgColor: ColorUtils.colorTextLogo,
          onTap: () {
            pushTo(context, DrawCardView(type: payType = 2,balance: GlobalCache().loginData.account.balance,));
          },
        )
      ],
    );
  }
  Widget _buildHistoryTranscation() {
    return BlocConsumer<HistoryTransactionBloc, HistoryTranscationState>(
        listener: (context, state) {
      if (state.status == AppConstants.STATUS_FAILURE) {
        Utilities.showToast(context, state.err);
      }
    }, builder: (context, state) {
      num sum = 0;
      state.transactionHistoryModel.forEach((element) {
        sum += element.amount;
      });
      return state.transactionHistoryModel != null
          ? Expanded(
              child: RefreshIndicator(
              onRefresh: () async {
                bloc.add(HistoryTranscationStartedEvent());
                await Future.delayed(Duration(seconds: 1));
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: setWidth(16),
                    right: setWidth(16),
                    top: setHeight(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lịch sử rút tiền",
                        style: FontUtils.medium.copyWith(fontSize: setSp(16))),
                    Text(Utilities.formatMoney(sum, suffix: 'đ'),
                        style: FontUtils.medium
                            .copyWith(color: ColorUtils.TEXT_PRICE)),
                    SizedBox(height: setHeight(10)),
                    ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.transactionHistoryModel.length,
                        itemBuilder: (context, index) {
                          return _itemHistoryTranscation(
                              state.transactionHistoryModel[index]);
                        }),
                  ],
                ),
              ),
            ))
          : CircularProgressIndicator(
              backgroundColor: ColorUtils.colorTextLogo,
            );
    });
  }
  Widget _itemHistoryTranscation(
      TransactionHistoryModel transactionHistoryModel) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: setWidth(10)),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorUtils.colorStatus),
            child:
                Image.asset(getAssetsIcon("donal.png"), height: setHeight(20)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Bạn đã rút thành công + ${Utilities.formatMoney(transactionHistoryModel.amount ?? 0, suffix: 'đ')}",
                  style: FontUtils.medium.copyWith(
                      fontSize: setSp(12), color: ColorUtils.NUMBER_PAGE)),
              Text(
                  Utilities.getTimeDiff(
                      time: transactionHistoryModel.createdDateStr ?? ""),
                  style: FontUtils.normal.copyWith(
                      fontSize: setSp(11), color: ColorUtils.TEXT_NAME))
            ],
          ),
          Spacer(),
          Text(
              Utilities.formatMoney(transactionHistoryModel.amount ?? 0,
                  suffix: 'đ'),
              style: FontUtils.medium.copyWith(
                  fontSize: setSp(12), color: ColorUtils.colorTextLogo))
        ],
      ),
    );
  }
}
