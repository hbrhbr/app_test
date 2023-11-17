import 'package:app_test/util/app_strings.dart';
import 'package:app_test/util/color_constants.dart';
import 'package:app_test/util/images.dart';
import 'package:app_test/util/styles.dart';
import 'package:app_test/view/screens/MainScreen/widgets/placeholder_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Watch/watch_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key,}) : super(key: key);

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> with AutomaticKeepAliveClientMixin{
  int currentPageIndex = 1;
  final PersistentTabController _controller= PersistentTabController(initialIndex: 1);


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: PersistentTabView(
        context,
        navBarHeight: 75,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        onItemSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        padding: const NavBarPadding.all(10),
        backgroundColor: AppColor.bottomNavColor,
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(27.0),
          colorBehindNavBar: AppColor.bottomNavColor,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.once,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 0),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          animateTabTransition: false,
          curve: Curves.ease,
          duration: Duration(milliseconds: 0),
        ),
        navBarStyle: NavBarStyle.simple, // Choose the nav bar style with this property.
      ),
    );
  }


  List<Widget> _buildScreens() {
    return const [
      PlaceHolderScreen(),
      WatchScreen(),
      PlaceHolderScreen(),
      PlaceHolderScreen(),
    ];
  }


  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      bottomNavBarItem(Images.dashboard, AppString.dashBoard, isSelected: currentPageIndex==0),
      bottomNavBarItem(Images.watch, AppString.watch, isSelected: currentPageIndex==1),
      bottomNavBarItem(Images.library, AppString.mediaLibrary, isSelected: currentPageIndex==2),
      bottomNavBarItem(null, AppString.more, isSelected: currentPageIndex==3),
    ];
  }

  PersistentBottomNavBarItem bottomNavBarItem(String ?assetImage, String title, {double height = 18, double width = 18, bool isSelected = false}){
    return PersistentBottomNavBarItem(
      icon: assetImage==null ? Icon(Icons.list, color: isSelected ? AppColor.bottomNavSelectedColor : AppColor.bottomNavUnSelectedColor,) : SizedBox(height: height, width: width, child: Image.asset(assetImage, height: height, width: width, fit: BoxFit.contain, color: isSelected ? AppColor.bottomNavSelectedColor : AppColor.bottomNavUnSelectedColor,)),
      title: title,
      iconSize: 20,
      contentPadding: 0,
      activeColorPrimary: AppColor.bottomNavSelectedColor,
      inactiveColorPrimary: AppColor.bottomNavUnSelectedColor,
      textStyle: poppinsRegular.copyWith(
        fontSize: 10,
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400
      )
    );
  }

  @override
  bool get wantKeepAlive => true;

}
