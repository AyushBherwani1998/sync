import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

mixin SyncToast {
  static void showErrorToast(BuildContext context, String errorMessage,
      {Duration duration = const Duration(seconds: 2)}) {
    BotToast.showSimpleNotification(
      title: errorMessage,
      duration: duration,
      backgroundColor: Colors.red,
      titleStyle: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  static void showSuccessToast(BuildContext context, String successMessage) {
    BotToast.showSimpleNotification(
      title: successMessage,
      backgroundColor: Colors.green,
      titleStyle: const TextStyle(
        color: Colors.white,
      ),
    );
  }

  static void showToast(BuildContext context, String message) {
    BotToast.showSimpleNotification(title: message);
  }
}
