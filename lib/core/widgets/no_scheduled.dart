import 'package:yomnista/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NoScheduledWidget extends StatelessWidget {
  const NoScheduledWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/no_scheduled.svg', width: 250),
          Text('لا يوجد حجوزات قادمة', style: getbodyStyle()),
        ],
      ),
    );
  }
}
