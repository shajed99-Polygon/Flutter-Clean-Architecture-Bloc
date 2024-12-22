import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../services/navigation/navigation_service.dart';

const _defaultPadding = 24.0;
const _maxBoxWidth = 400.0;

class SnackBarUtils {
  static Future<void> showSnackBar({
    required String title,
    required String message,
    Widget? icon,
    SnackPosition snackPosition = SnackPosition.BOTTOM,
    void Function(SnackbarStatus? status)? snackbarStatus,
    TextButton? mainButton,
    Duration duration = const Duration(seconds: 5),
    Duration? animationDuration,
    Completer<void>? completer,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Widget? child,
  }) async {
    final Completer<void> completer_ = completer ?? Completer<void>();
    if (Get.isSnackbarOpen) Get.closeAllSnackbars();

    final theme = Get.theme;

    Get.snackbar(
      title,
      message,
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface)),
          if (child != null)
            Padding(
              padding: const EdgeInsets.only(top: _defaultPadding / 4),
              child: child,
            )
        ],
      ),
      icon: icon,
      borderRadius: _defaultPadding / 2,
      padding: padding ?? const EdgeInsets.all(_defaultPadding),
      margin: margin ?? const EdgeInsets.all(_defaultPadding),
      snackPosition: snackPosition,
      snackbarStatus: (status) async {
        if (snackbarStatus != null) snackbarStatus(status);
        if (status == SnackbarStatus.CLOSED && !completer_.isCompleted) {
          await Future.delayed(const Duration(milliseconds: 100));
          completer_.complete();
        }
      },
      colorText: theme.colorScheme.onPrimaryContainer,
      maxWidth: _maxBoxWidth,
      backgroundColor: theme.colorScheme.primaryContainer.withOpacity(0.7),
      mainButton: mainButton,
      duration: duration,
      animationDuration: animationDuration,
    );

    await completer_.future;
  }

  static void showError({EdgeInsets? margin, String? message, Color? color, TextStyle? style, SnackBarBehavior? snackBarBehavior, BuildContext? context}) {
    if (kDebugMode) print('error message : $message');

    TextStyle defaultStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF2F3137),
    );

    final snackBar = GetSnackBar(
      messageText: Text(
        message ?? 'Error! Try Again...',
        style: style ?? defaultStyle,
      ),
      backgroundColor: color ?? Colors.red,
      dismissDirection: DismissDirection.up,
      // behavior: snackBarBehavior ?? SnackBarBehavior.fixed,
      margin: margin ?? const EdgeInsets.all(0),
    );
    Get.showSnackbar(snackBar);
  }

  static void showSuccess({String message = 'Success!', Color? color}) {
    TextStyle defaultStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF2F3137),
    );

    final snackBar = GetSnackBar(
      messageText: Text(
        message,
        style: defaultStyle,
      ),
      backgroundColor: color ?? Colors.green,
    );
    Get.showSnackbar(snackBar);
  }
}
