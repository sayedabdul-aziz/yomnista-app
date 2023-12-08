import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomBackAction extends StatelessWidget {
  const CustomBackAction({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_sharp,
          color: AppColors.color1,
        ));
  }
}
