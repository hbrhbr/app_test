import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ApiLoader{
  static bool isShowingLoader = false;

  static Future<void>show()async{
    isShowingLoader = true;
    Get.dialog(
      WillPopScope(
        onWillPop: ()async{
          return false;
        },
        child: LoadingAnimationWidget.flickr(
          leftDotColor: Get.theme.primaryColor,
          rightDotColor: Get.theme.primaryColorDark,
          size: 35,
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void hide(){
    if(isShowingLoader){
      isShowingLoader = false;
      Get.back();
    }
  }
}