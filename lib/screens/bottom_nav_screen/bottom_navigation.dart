import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neumorphism_project/screens/profile/profile.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import '../../widgets/app_color.dart';
import '../../widgets/font_size.dart';
import '../../widgets/style_insets.dart';
import '../../widgets/text_style.dart';
import '../dashboard/dashboard.dart';
import '../home/home.dart';
import '../setting_page/setting.dart';

class BottomNavigatiion extends StatefulWidget {
  BuildContext? bottomScreenContext;

  BottomNavigatiion({Key? key}) : super(key: key);
  static const routeName = '/bottomnavscreen';
  @override
  State<BottomNavigatiion> createState() => _BottomNavigatiionState();
}

class _BottomNavigatiionState extends State<BottomNavigatiion> {
  PersistentTabController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    setState(() {
      _controller?.index;
    });
  }

  BottomIndexCallback(int sval) {
    setState(() {
      _controller?.index = sval;
    });
    print('BottomIndexCallback---??$sval');
  }

  Localecallback() {}

  List<Widget> _buildScreens() {
    return [
      DashBoard(
          menuScreenContext: widget.bottomScreenContext,
          hideStatus: false,
          bottomindexCallback: BottomIndexCallback,
          localecallback: Localecallback),
      HomePage(
          menuScreenContext: widget.bottomScreenContext,
          hideStatus: false,
          bottomindexCallback: BottomIndexCallback,
          localecallback: Localecallback),
      Settingpage(
          menuScreenContext: widget.bottomScreenContext,
          hideStatus: false,
          bottomindexCallback: BottomIndexCallback,
          localecallback: Localecallback),
      Profile(
          menuScreenContext: widget.bottomScreenContext,
          hideStatus: false,
          bottomindexCallback: BottomIndexCallback,
          localecallback: Localecallback)
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems1() {
    /* Map? args = ModalRoute.of(context)!.settings.arguments as Map?;
    print('ARG ##${args?.length}');*/
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.dashboard,
          size: Insets.lg+Insets.sm,
        ),
        inactiveIcon: Icon(
          Icons.dashboard,
          size: Insets.lg+Insets.sm,
        ),
        title: 'Dashboard',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black45,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home_outlined,
          size: Insets.lg+Insets.sm,
        ),
        inactiveIcon: Icon(
          Icons.home_outlined,
          size: Insets.lg+Insets.sm,
        ),
        title: 'Home', //'${dashTranslation!=null?dashTranslation!.labelhome:'Home'}',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black45,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.settings,
          size: Insets.lg+Insets.sm,
        ),
        inactiveIcon: Icon(
          Icons.settings,
          size: Insets.lg+Insets.sm,
        ),
        title: 'Settings',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black45,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person,
          size: Insets.lg+Insets.sm,
        ),
        inactiveIcon: Icon(
          Icons.person,
           size: Insets.lg+Insets.sm,
        ),
        title: 'Profile',
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black45,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: PersistentTabView.custom(
        context,
        controller: _controller,
        backgroundColor: Colors.white,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        stateManagement: false,
        hideNavigationBar: false,
        hideNavigationBarWhenKeyboardShows: true,
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 100),
        ),
        screens: _buildScreens(),
        customWidget: CustomBottomNavBar(
          items: _navBarsItems1(),
          onItemSelected: (index) {
            setState(() {
              Map? args = ModalRoute.of(context)!.settings.arguments as Map?;
              print('selectedIndexTab$index' '${args?.length}');
              index == 0
                  ? Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(
                      pageBuilder: (BuildContext context, Animation animation,
                          Animation secondaryAnimation) {
                      return BottomNavigatiion();
                    }), (Route<dynamic> route) => false)
                  : '';
              _controller!.index = index; // THIS IS CRITICAL!! Don't miss it!
            });
          },
          selectedIndex: _controller!.index,
        ),
        itemCount: 4,
        routeAndNavigatorSettings: CutsomWidgetRouteAndNavigatorSettings(
          initialRoute: '/',
          onGenerateRoute: (RouteSettings routeSettings) {
            return PageRouteBuilder(
                settings: routeSettings,
                pageBuilder: (BuildContext context, Animation animation,
                    Animation secondaryAnimation) {
                  Map? args = routeSettings.arguments as Map?;
                  print('selectedrouteSettings ${routeSettings.name}');
                  switch (routeSettings.name) {
                    case DashBoard.routeName:
                      return DashBoard(
                          hideStatus: false,
                          bottomindexCallback: BottomIndexCallback,
                          localecallback: Localecallback());
                    default:
                      return BottomNavigatiion();
                  }
                },
              //  opaque: false,
                barrierColor: Colors.transparent,
                transitionDuration: Duration(milliseconds: 100),
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child) {
                  return FadeTransition(
                    alwaysIncludeSemantics: true,
                    opacity: animation,
                    child: SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  final int? selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int>? onItemSelected;
  CustomBottomNavBar({
    Key? key,
    this.selectedIndex,
    required this.items,
    this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Padding(
      padding: EdgeInsets.all(Insets.xs),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: Insets.xxl - 25,
                  color: isSelected
                      ? (item.activeColorSecondary == null
                          ? item.activeColorPrimary
                          : item.activeColorSecondary)
                      : item.inactiveColorPrimary == null
                          ? item.activeColorPrimary
                          : item.inactiveColorPrimary),
              child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
            ),
          ),
          Material(
            type: MaterialType.transparency,
            child: FittedBox(
                child: textStyle(
              text: '${item.title}',
              style: TextStyle(
                color: isSelected
                    ? (item.activeColorSecondary == null
                        ? item.activeColorPrimary
                        : item.activeColorSecondary)
                    : item.inactiveColorPrimary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                fontSize: FontSizes.s8,
              ),
            )),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight:Radius.circular(Insets.xl),topLeft: Radius.circular(Insets.xl)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 2.0), //(x,y)
              blurRadius: 6.0,
            ),
          ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          return Flexible(
            child: GestureDetector(
              onTap: () {
                this.onItemSelected!(index);
              },
              child: _buildItem(item, selectedIndex == index),
            ),
          );
        }).toList(),
      ),
    );
  }
}
