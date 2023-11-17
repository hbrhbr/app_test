import 'package:app_test/util/dimensions.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:app_test/util/styles.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  if(message.isNotEmpty) {
    BotToast.showSimpleNotification(
      title: message,
      subTitle: null,
      enableSlideOff: true,
      hideCloseButton: true,
      dismissDirections: const [DismissDirection.up],
      borderRadius: Dimensions.RADIUS_SMALL,
      align: Alignment.topCenter,
      backgroundColor: isError ? Colors.red : Colors.green,
      titleStyle: poppinsSemiBold.copyWith(color: Colors.white),
      subTitleStyle: poppinsSemiBold.copyWith(color: Colors.white),
      onlyOne: true,
      crossPage: true,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 3),
    );
  }
}