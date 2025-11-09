import 'dart:io';
import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

Future<bool> alertExitApp(BuildContext context) async {
  return await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "تنبيه",
            style: TextStyle(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text("هل تريد الخروج من التطبيق"),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                exit(0);
              },
              child: const Text("تاكيد", style: TextStyle(color: Colors.white)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("الغاء", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ) ??
      false;
}
