import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mamo_app/bloc/request_task/request_task_bloc.dart';
import 'package:mamo_app/bloc/request_task/request_task_event.dart';
import 'package:mamo_app/bloc/request_task/request_task_state.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/utilities.dart';
import 'package:mamo_app/widget/app_constant.dart';
import 'package:mamo_app/widget/common_appbar.dart';
import 'package:mamo_app/widget/custombutton.dart';
import 'package:mamo_app/widget/global_cache.dart';

class ReadDeltailPage extends StatefulWidget {
  final num type;

  const ReadDeltailPage({Key key, this.type}) : super(key: key);

  @override
  _ReadDeltailPageState createState() => _ReadDeltailPageState();
}

class _ReadDeltailPageState extends State<ReadDeltailPage> {
  RequestTaskBloc _requestTaskBloc;

  @override
  void initState() {
    _requestTaskBloc = BlocProvider.of<RequestTaskBloc>(context);
    _requestTaskBloc.add(RequestStartedEvent(type: widget.type));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.WHITE,
      appBar: appbarDefault(
          context,
          widget.type == AppConstants.READ_TYPE_BOOK
              ? "Đọc Truyện"
              : "Đọc báo"),
      body: Column(
        children: [
          Center(
            child: Image.asset(getAssetsImage("info_kiemtien.png"),
                height: setHeight(200)),
          ),
          _buildTutorialRead(),
        ],
      ),
    );
  }
  Widget _buildTutorialRead() {
    return BlocConsumer<RequestTaskBloc, RequestTaskState>(
        listener: (context, state) {
      if (state.status == AppConstants.STATUS_FAILURE) {
        // _buildError();
        // Utilities.showToast(context, state.err);
      }
    }, builder: (context, state) {
      return
        state.requestTask == null
          ? _buildError(state.err) :
      Container(
        padding: EdgeInsets.all(16),
        child: Column(
                children: [
                  Text(state.requestTask != null
                      ? state.requestTask.description ?? ""
                      : ""),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ButtonCustom(
                        title: "Hoàn thành",
                        width: setWidth(165),
                        height: setHeight(45),
                        borderRadius: 12,
                        bgColor: ColorUtils.colorStatus,
                        textStyle: FontUtils.medium
                            .copyWith(color: ColorUtils.colorTextLogo),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(width: setWidth(10)),
                      ButtonCustom(
                        title: "Copy Link",
                        width: setWidth(165),
                        height: setHeight(45),
                        borderRadius: 12,
                        bgColor: ColorUtils.colorTextLogo,
                        textStyle:
                            FontUtils.medium.copyWith(color: ColorUtils.WHITE),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: setHeight(50)),
                  Text("Để thực hiện nhiệm vụ, vui lòng bấm vào nút [Copy Link]. Sau đó, bạn sang trình duyệt và Paste vào thanh địa chỉ để đọc. Chú ý không Paste vào tìm kiếm Google.",
                    style: FontUtils.normal.copyWith(fontSize: setSp(13),color: ColorUtils.TEXT_NAME),overflow: TextOverflow.clip,textAlign: TextAlign.justify,textScaleFactor: 1,),
                  SizedBox(height: setHeight(5)),
                  Text("Sau khi đọc đủ số lượng trang vào thời gian yêu cầu. Bạn vui lòng qua lại App Mamo để bấm nút hoàn thành nhiệm vụ",
                    style: FontUtils.normal.copyWith(fontSize: setSp(13),color: ColorUtils.TEXT_NAME),overflow: TextOverflow.clip,textAlign: TextAlign.justify,textScaleFactor: 1,
                  ),
                ],
              ),
      );
    });
  }
  Widget _buildError(String err) {
    return Container(
      margin: EdgeInsets.only(top: setHeight(16)),
      child: Column(
        children: [
          Text(
            err ?? "Có lỗi khi nhận nhiệm vụ",
            // GlobalCache().errorMessage ?? "Có lỗi khi nhận nhiệm vụ",
              style: FontUtils.normal.copyWith(color: ColorUtils.TEXT_NAME)),
          SizedBox(height: setHeight(20)),
          ButtonCustom(
            textStyle: FontUtils.medium.copyWith(color: ColorUtils.WHITE),
            height: setHeight(42),
            width: setWidth(200),
            title: "Đóng",
            borderRadius: 12,
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
