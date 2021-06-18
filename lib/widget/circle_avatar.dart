

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mamo_app/api/api_constants.dart';
import 'package:mamo_app/utils/color_utils.dart';
import 'package:mamo_app/utils/font_utils.dart';
import 'package:mamo_app/utils/global_functions.dart';
import 'package:mamo_app/utils/utilities.dart';

Widget circleAvatar(String path,String replaceName,{double radius = 36}) {
  radius = setWidth(radius);
  return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        width: radius*2,
        height: radius*2,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Container(
          child: Center(
            child: Text(Utilities.getAcronym(replaceName).toUpperCase(),style: FontUtils.medium.copyWith(color: Colors.white),),
          ),
          color: ColorUtils.DEFAULT_AVATAR_COLOR[Utilities.getRandomNumber(replaceName, ColorUtils.DEFAULT_AVATAR_COLOR.length)],
          width: radius*2,
          height: radius*2,
        ),
        imageUrl:  ApiConstants.shared.getFullImage(path),
      )
  );
}
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:mamo_app/utils/colors.dart';
// import 'package:mamo_app/utils/font_utils.dart';
// import 'package:mamo_app/utils/global_functions.dart';
// import 'package:mamo_app/utils/utilities.dart';
//
// class CustomCircleAvatar extends StatelessWidget {
//   CustomCircleAvatar({Key key, this.path, this.replaceName, this.radius = 25})
//       : super(key: key);
//
//   final String path;
//   final String replaceName;
//   final double radius;
//
//   @override
//   Widget build(BuildContext context) {
//     var kRadius = setWidth(radius);
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(kRadius),
//       child: CachedNetworkImage(
//         // color: ColorConstants.DEFAULT_AVATAR_COLOR[Utilities.getRandomNumber(
//         //     replaceName, ColorConstants.DEFAULT_AVATAR_COLOR.length)],
//         width: kRadius * 2,
//         height: kRadius * 2,
//         fit: BoxFit.cover,
//         placeholder: (context, url) => Container(
//           padding: EdgeInsets.all(12),
//           child: CircularProgressIndicator(
//             strokeWidth: 2,
//           ),
//         ),
//         errorWidget: (context, url, error) => Container(
//           color: ColorConstants.DEFAULT_AVATAR_COLOR[Utilities.getRandomNumber(
//               replaceName, ColorConstants.DEFAULT_AVATAR_COLOR.length)],
//           child: Center(
//             child: Text(
//               Utilities.getAcronym(replaceName).toUpperCase(),
//               style: FontUtils.semibold.copyWith(color: Colors.white),
//             ),
//           ),
//           width: kRadius * 2,
//           height: kRadius * 2,
//         ),
//         imageUrl: Utilities.getFullImagePath(path),
//       ),
//     );
//   }
// }
