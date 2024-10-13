import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../services/navigation/navigation_service.dart';
import '../../../core_export.dart';

///----------------- Custom Toast Using fluttertoast -----------------///
void showCustomToast(
    {required String msg, Color? bg, ToastGravity? gravity, Toast? length}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: length ?? Toast.LENGTH_SHORT,
    gravity: gravity ?? ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: bg ?? AppColors().colorPrimary,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

/// has no support for android 12, so don't use now
void showCustomToastWithCustomDuration(
    {required String message,
    required int durationInSecond,
    ToastGravity? gravity,
    Color? color}) {
  FToast toast = FToast();
  BuildContext? context = NavigationService.navigatorKey.currentContext;
  if (context != null) {
    toast.init(context);
    toast.showToast(
      child: getChild(message, color),
      toastDuration: Duration(seconds: durationInSecond),
      gravity: gravity ?? ToastGravity.BOTTOM,
    );
  }
}

Widget getChild(String message, Color? color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: color ?? AppColors().primaryColor,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message),
      ],
    ),
  );
}

///----------------- Custom Toast Using SnackBar -----------------///

enum SnackBarType { success, error, custom }

void showCustomSnackbar(
    BuildContext context, {
      required String message,
      SnackBarType? type,
      Color? backgroundColor,
      IconData? icon,
      Color? iconColor,
      Color? bottomLineColor,
      Duration duration = const Duration(seconds: 2),
    }) {
  // Define default values based on the type
  Color? defaultIconColor;
  IconData? defaultIcon;
  Color? defaultBottomLineColor;

  switch (type) {
    case SnackBarType.success:
      defaultIconColor = Colors.green;
      defaultIcon = Icons.check_circle;
      defaultBottomLineColor = Colors.green;
      break;
    case SnackBarType.error:
      defaultIconColor = Colors.red;
      defaultIcon = Icons.error;
      defaultBottomLineColor = Colors.red;
      break;
    case SnackBarType.custom:
    default:
      break;
  }

  final snackBar = SnackBar(
    content: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          color: backgroundColor ?? Colors.white,
          child: Row(
            children: [
              if (icon != null || defaultIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    icon ?? defaultIcon,
                    color: iconColor ?? defaultIconColor ?? Colors.black,
                  ),
                ),
              Expanded(
                child: Text(
                  message,
                  textAlign: icon != null || defaultIcon != null ? TextAlign.left : TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (bottomLineColor != null || defaultBottomLineColor != null)
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Container(
              height: 4.0,
              color: bottomLineColor ?? defaultBottomLineColor,
            ),
          ),
      ],
    ),
    backgroundColor: Colors.transparent,
    duration: duration,
    behavior: SnackBarBehavior.floating,
    padding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}