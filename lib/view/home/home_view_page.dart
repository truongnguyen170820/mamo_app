import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/bloc/home/home_bloc.dart';
import 'package:mamo_app/bloc/home/home_envet.dart';
import 'package:mamo_app/bloc/home/home_state.dart';
import 'package:mamo_app/bloc/readers/readers_bloc.dart';
import 'package:mamo_app/bloc/readers/readers_event.dart';
import 'package:mamo_app/bloc/readers/readers_state.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/colors.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/screen_utils.dart';
import 'package:mamo_app/utils/text_styles.dart';
import 'package:mamo_app/utils/utilities.dart';
import 'package:mamo_app/view/home/deltail_read_page.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'package:mamo_app/widget/circle_avatar.dart';
import 'package:mamo_app/widget/custombutton.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({Key key}) : super(key: key);

  @override
  _HomeViewPageState createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HomeBloc _homeBloc;
  ReadersBloc _readersBloc;

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(HomeStattedEvent());
    _readersBloc = BlocProvider.of<ReadersBloc>(context);
    _readersBloc.add(ReadersStartedEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: _buildAppBar(),
      drawer: _drawView(),
      body: Container(
        margin: EdgeInsets.only(
            left: setWidth(16), right: setWidth(16), top: setHeight(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hôm nay",
                style: FontUtils.medium.copyWith(fontSize: setSp(16))),
            SizedBox(height: setHeight(16)),
            _buildCart(),
            _buildMakeMoney(),
            SizedBox(height: setHeight(16)),
            Text("Cộng đồng độc giả",
                style: FontUtils.medium.copyWith(fontSize: setSp(16))),
            SizedBox(height: setHeight(16)),
            _buildReader()
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        'Trang chủ',
        style: TextStyles.kMedium16Primary.copyWith(
          color: ColorConstants.TEXT_NORMAL,
        ),
      ),
      leading: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            _scaffoldKey.currentState.openDrawer();
          },
          child: Image.asset(getAssetsIcon("hp_drawer.png")),
          // ),
        ),
      ),
      // actions: [_buildNotificationItem()],
      centerTitle: true,
    );
  }
  Widget _buildCart() {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.status == AppConstants.STATUS_FAILURE) {
          Utilities.showToast(context, state.err);
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            _buildItemViewRead(
                "Đọc truyện",
                state.homeStatitics == null
                    ? 0
                    : state.homeStatitics.totalMoneyReadStory ?? "",
                state.homeStatitics == null
                    ? 0
                    : state.homeStatitics.numPageReadStory ?? ""),
            SizedBox(width: setWidth(13)),
            _buildItemViewRead(
                "Đọc báo",
                state.homeStatitics == null
                    ? 0
                    : state.homeStatitics.totalMoneyReadNews ?? "",
                state.homeStatitics == null
                    ? 0
                    : state.homeStatitics.numPageReadNews ?? "")
          ],
        );
      },
    );
  }
  Widget _buildItemViewRead(String read, num money, num page) {
    return Container(
      height: setHeight(165),
      width: setWidth(165),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorUtils.underlined, width: 2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: ColorUtils.BG_ICOn,
                  borderRadius: BorderRadius.circular(15)),
              child: Image.asset(
                getAssetsIcon("readbook.png"),
                height: setHeight(24),
                width: setWidth(24),
              )),
          SizedBox(height: setHeight(9)),
          Text(read,
              style: FontUtils.normal
                  .copyWith(color: ColorUtils.TEXT_NAME, fontSize: setSp(12))),
          Text("${Utilities.formatMoney(money, suffix: 'đ')}",
              style: FontUtils.bold
                  .copyWith(fontSize: setSp(18), color: ColorUtils.TEXT_PRICE)),
          Text("(${page} trang)",
              style: FontUtils.bold
                  .copyWith(fontSize: setSp(12), color: ColorUtils.NUMBER_PAGE))
        ],
      ),
    );
  }
  Widget _buildMakeMoney() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildItemTutorial("Đọc truyện", ontap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ReadDeltailPage(type: AppConstants.READ_TYPE_BOOK)));
        }),
        _buildItemTutorial("Đọc báo", ontap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReadDeltailPage(
                        type: AppConstants.READ_TYPE_NEWS,
                      )));
        })
      ],
    );
  }
  Widget _buildItemTutorial(String nameRead, {Function ontap, Function ontap1}) {
    return Container(
      height: setHeight(58),
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorUtils.colorStatus),
              child: Image.asset(
                getAssetsIcon("readbook.png"),
                height: setHeight(18),
                color: ColorUtils.colorTextLogo,
              )),
          SizedBox(width: setWidth(11)),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nameRead, style: FontUtils.bold),
              SizedBox(height: setHeight(3)),
              GestureDetector(
                  onTap: ontap1,
                  child: Text("Hướng dẫn >>",
                      style: FontUtils.normal.copyWith(
                          fontSize: setSp(12),
                          color: ColorUtils.colorTextLogo)))
            ],
          ),
          Spacer(),
          ButtonCustom(
            onTap: ontap,
            height: setHeight(36),
            width: setWidth(90),
            title: "Đọc",
            textStyle: FontUtils.medium.copyWith(color: ColorUtils.WHITE),
            borderRadius: 12,
            bgColor: ColorUtils.TEXT_PRICE,
          )
        ],
      ),
    );
  }
  Widget _buildReader() {
    return BlocConsumer<ReadersBloc, ReadersState>(
        listener: (context, state) {
      if (state.status == AppConstants.STATUS_FAILURE) {
        Utilities.showToast(context, state.err);
      }
    }, builder: (context, state) {
      return state.recentRewardReader != null
          ? Expanded(
              child: RefreshIndicator(
              onRefresh: () async {
                _readersBloc.add(ReadersStartedEvent());
                await Future.delayed(Duration(seconds: 1));
              },
              child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: state.recentRewardReader.length,
                  itemBuilder: (context, index) {
                    String name = state.recentRewardReader[index].fullName??"";
                    String readType = Utilities.getReadType(state.recentRewardReader[index].readType??"");
                return Container(
                  margin: EdgeInsets.only(top: setHeight(8), bottom: setHeight(8)),
                  child: Row(
                    children: [
                      circleAvatar(state.recentRewardReader[index].fullName,
                          state.recentRewardReader[index].fullName, radius: 30),
                      SizedBox(width: setWidth(13)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name + " vừa " + readType, style: FontUtils.bold.copyWith(color: ColorUtils.NUMBER_PAGE, fontSize: setSp(13))),
                          Text(Utilities.getTimeDiff(time: state.recentRewardReader[index].transationTimeStr??""),
                              style: FontUtils.normal.copyWith(color: ColorUtils.gray2, fontSize: setSp(12)),)
                        ],
                      ),
                      Spacer(),
                      Text("+" + Utilities.formatMoney(state.recentRewardReader[index].amount, suffix: 'đ'),
                      style: FontUtils.bold.copyWith(color: ColorUtils.colorTextLogo),
                      )
                    ],
                  ),
                );
              }),
            ))
          : CircularProgressIndicator(
        backgroundColor: ColorUtils.colorTextLogo,
      );
    });
  }
  Widget _drawView(){
    return Column(
      children: [
        Container(
          height: setHeight(150),
        color: ColorUtils.colorTextLogo,
          child: Row(
            children: [
              circleAvatar("", "", radius: 30),
            ],
          ),
        ),

      ],
    );
  }
  Widget _buildItemDraw(){
    return Container(
      child: Row(
        children: [
          
        ],
      ),
    );
  }
}
