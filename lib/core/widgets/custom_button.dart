import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.text, this.onTap, this.height = 50});

  final String text;
  final void Function()? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.color1, borderRadius: BorderRadius.circular(5)),
        child: Text(
          text,
          style: TextStyle(
              color: AppColors.scaffoldBG, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
