import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/widget/common_appbar.dart';
import 'package:mamo_app/widget/custombutton.dart';
import 'package:mamo_app/widget/global_cache.dart';
import 'package:mamo_app/widget/item_show_money.dart';

class DrawCardView extends StatefulWidget {
  final num balance;
  int type;

  DrawCardView({this.type, this.balance});

  @override
  _DrawCardViewState createState() => _DrawCardViewState();
}

class _DrawCardViewState extends State<DrawCardView> {
  TextEditingController _userMomoCtrl = TextEditingController();
  TextEditingController _moneyMomoCtrl = TextEditingController();
  TextEditingController _passwordMomoCtrl = TextEditingController();
  NumberFormat nf = NumberFormat("###,###,###", "en_US");
  List<String> telcoListLabel = [
    'Vinaphone',
    'Mobifone',
    'Viettel',
  ];
  String telcoName;
  int amount;
  int cardValue;
  @override
  void initState() {
    // _userMomoCtrl.text = nf.format(widget.balance);
    _userMomoCtrl.text = GlobalCache().loginData.momoMobile;
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarDefault(context, "Yều cầu rút tiền"),
      body: Column(
        children: [
          CustomItemShowMoney("Số tiền trong ví", widget.balance ?? 0),
          _buildWithdrawal(),
          if (widget.type == 1) _buildWithdrawMomo(),
          if (widget.type == 2) _buildWithdrawPhone()
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
          bgColor: widget.type == 1 ? ColorUtils.TEXT_PRICE : ColorUtils.underlined,
          textStyle: FontUtils.medium.copyWith(
              color:
                  widget.type == 1 ? ColorUtils.WHITE : ColorUtils.TEXT_NAME),
          onTap: () {
            setState(() {
              widget.type = 1;
            });
          },
        ),
        ButtonCustom(
          height: setHeight(45),
          width: setWidth(160),
          borderRadius: 12,
          title: "RÚT THẺ ĐT",
          bgColor: widget.type != 2 ? ColorUtils.underlined : ColorUtils.TEXT_PRICE,
          textStyle: FontUtils.medium.copyWith(
              color: widget.type == 2
                  ? ColorUtils.underlined
                  : ColorUtils.TEXT_NAME),
          onTap: () {
            setState(() {
              widget.type = 2;
            });
          },
        )
      ],
    );
  }
  Widget _buildWithdrawMomo() {
    return Container(
      margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16), top: setHeight(16)),
      child: Column(
        children: [
          _itemWithDrawal("Tài khoản Momo", "Nhập tài khoản Momo", _userMomoCtrl, suffixText: GlobalCache().loginData.momoName ?? ""),
          _itemWithDrawal("Số tiền rút", "Nhập số tiền", _moneyMomoCtrl),
            _itemWithDrawal(
                "Mật khẩu App Mamo", "Nhập mật khẩu", _passwordMomoCtrl),
          Text(
              "Số tiền rút phải là bội số của 10.000đ, ví dụ: 10.000đ, 20.000đ, 30.000đ...Số tiền rút tối đa mỗi lần rút là 200.000đ.")
        ],
      ),
    );
  }
  Widget _buildWithdrawPhone(){
    return Container(
      margin: EdgeInsets.only(top: setHeight(16), bottom: setHeight(10),  right: setWidth(16), left: setWidth(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Chọn nhà mạng",  style: FontUtils.normal
              .copyWith(color: ColorUtils.gray1, fontSize: setSp(12))),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: setHeight(6), bottom: setHeight(10)),
            padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            decoration: BoxDecoration(
                color: ColorUtils.underlined,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorUtils.gray2)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: telcoName,
                icon: Icon(Icons.keyboard_arrow_down, color: ColorUtils.TEXT_NAME,),
                onChanged: (String newValue) {
                  setState(() {
                    telcoName = newValue;
                  });
                },
                items: [0, 1, 2]
                    .map<DropdownMenuItem<String>>((int value) {
                  return DropdownMenuItem<String>(
                    value: telcoListLabel[value],
                    child: Text(
                      telcoListLabel[value],
                      style: FontUtils.medium.copyWith(color: ColorUtils.NUMBER_PAGE),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Text("Mệnh giá thẻ",  style: FontUtils.normal
              .copyWith(color: ColorUtils.gray1, fontSize: setSp(12))),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            margin: EdgeInsets.only(top: setHeight(6), bottom: setHeight(10)),
            decoration: BoxDecoration(
                color: ColorUtils.underlined,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorUtils.gray2)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: cardValue,
                icon: Icon(Icons.keyboard_arrow_down, color: ColorUtils.TEXT_NAME,),
                onChanged: (int newValue) {
                  setState(() {
                    cardValue = newValue;
                  });
                },
                items: [
                  DropdownMenuItem<int>(
                    value: 10000,
                    child: Text(
                      '10,000',
                      style: FontUtils.medium.copyWith(color: ColorUtils.NUMBER_PAGE),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: 20000,
                    child: Text(
                      '20,000',
                      style: FontUtils.medium.copyWith(color: ColorUtils.NUMBER_PAGE),
                    ),
                  ),
                  DropdownMenuItem<int>(
                    value: 50000,
                    child: Text(
                      '50,000',
                      style: FontUtils.medium.copyWith(color: ColorUtils.NUMBER_PAGE),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _itemWithDrawal(
              "Mật khẩu App Mamo", "Nhập mật khẩu", _passwordMomoCtrl),
        ],
      ),
    );
  }
  Widget _itemWithDrawal(String nameItem, String hintText, TextEditingController controller,{String suffixText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(nameItem,
            style: FontUtils.normal
                .copyWith(color: ColorUtils.gray1, fontSize: setSp(12))),
        Container(
          padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
          margin: EdgeInsets.only(top: setHeight(6), bottom: setHeight(10)),
          decoration: BoxDecoration(
              color: ColorUtils.underlined,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorUtils.gray2)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: FontUtils.normal.copyWith(fontSize: setSp(12)),
              suffixText: suffixText,
              suffixStyle:
                  FontUtils.medium.copyWith(color: ColorUtils.NUMBER_PAGE),
            ),
          ),
        )
      ],
    );
  }
}
