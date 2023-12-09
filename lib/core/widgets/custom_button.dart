import 'package:borcelle_restaurant/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.text,
      this.onTap,
      this.height = 50,
      this.radius = 5,
      this.width = double.infinity});

  final String text;
  final void Function()? onTap;
  final double height;
  final double width;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.color1,
            borderRadius: BorderRadius.circular(radius)),
        child: Text(
          text,
          style: TextStyle(
              color: AppColors.scaffoldBG, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
