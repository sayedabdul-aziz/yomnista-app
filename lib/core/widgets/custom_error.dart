import 'package:flutter/material.dart';
import 'package:yomnista/core/utils/app_colors.dart';

showErrorDialog(BuildContext context, error, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color ?? AppColors.redColor,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(20),
      content: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Text(error))));
}
