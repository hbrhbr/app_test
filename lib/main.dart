import 'dart:async';
import 'dart:io';
import 'package:app_test/theme/light_theme.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'helper/get_di.dart' as di;
import 'helper/route_helper.dart';
import 'util/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (BuildContext context, Widget? child) {
        child = BotToastInit()(context, child);
        return child;
      },
      navigatorKey: Get.key,
      theme: light(),
      initialRoute: RouteHelper.getMainRoute(),
      getPages: RouteHelper.routes,
      defaultTransition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
