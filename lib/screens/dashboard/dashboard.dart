import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphism_project/screens/dashboard/Episodes/episodes_list.dart';
import 'package:neumorphism_project/screens/dashboard/location/location_list.dart';
import 'package:neumorphism_project/screens/dashboard/settings/settings.dart';
import 'package:neumorphism_project/widgets/style_insets.dart';
import 'package:neumorphism_project/widgets/style_space.dart';

import '../../widgets/font_size.dart';
import 'characters/characters_list.dart';

typedef BottomindexCallback = void Function(int val);
typedef Localecallback = void Function();
typedef Cartcntcallback = void Function();
typedef Playanicallback= void Function(bool val);
typedef TranslaterCallback = void Function(dynamic data);
typedef NavigationSlideupCallback =  Function(dynamic data);
typedef BookinginfoCallback = dynamic Function(dynamic val);


class DashBoard extends StatefulWidget {
   User? user;
  final BuildContext? menuScreenContext;
  late bool hideStatus;
  final BottomindexCallback bottomindexCallback;
  final Localecallback localecallback;
  static const routeName = '/bottomnavscreen';
   DashBoard({Key? key, /*this.user,*/this.menuScreenContext,
     required this.hideStatus,
     required this.bottomindexCallback,
     required this.localecallback}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool _isElevated = false;
  int _selectedIndex = 0;
  List<DashboardIcons> listsdash = [];
  final List<Map> myProducts = List.generate(12, (index) => {"id": index, "name": "Product $index"}).toList();

  @override
  void initState() {
    super.initState();
    if (listsdash.isNotEmpty) listsdash.clear();

    loadfirestoredata();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Users").doc(widget.user?.uid).snapshots(),
      builder: (context, snapshot) {
        var userDocument = snapshot.data;
        return Scaffold(
          extendBody: true,
          backgroundColor:  Colors.grey.withOpacity(0.2),
            appBar: AppBar(
              backgroundColor: Colors.white.withOpacity(0.1),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Dashboard',
                style: TextStyles.h3,
              ),
            //  iconTheme: IconThemeData(color: Colors.black, size: Insets.xl),
            ),
          body: Container(
            padding: EdgeInsets.only(right: Insets.med,left: Insets.med,top: Insets.med),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: listsdash.length,
                itemBuilder: (BuildContext context, int index) {
                  DashboardIcons  dashboardIcons = listsdash[index];
                  return Padding(padding: EdgeInsets.all(Insets.med),
                  child: GestureDetector(
                  onTap: (){
                    setState(() {
                      _selectedIndex = index;

                    });
                    dashboardIcons.iconId == 'CH'? Navigator.push(context, MaterialPageRoute(
                        builder: (context) => CharactersList())):
                    dashboardIcons.iconId == 'EP' ? Navigator.push(context, MaterialPageRoute(
                        builder: (context) => EpisodesList())):
                    dashboardIcons.iconId == 'LO'? Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>LocationList())):
                    dashboardIcons.iconId == 'SE'? Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>SettingsScreen())):
                    SizedBox();
                  },
                    child: Neumorphic(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(Insets.med)),
                        color: Colors.grey.shade200,
                        depth:  _selectedIndex == index? NeumorphicTheme.embossDepth(context):2.5,
                        intensity: 1.5,
                      ),
                      child: Center(child: dashboardIcons._icon),
                    ),
                  ),
                  );
                }
            ),
          )
        ) ;
      }

    );
  }

  void loadfirestoredata() {
    listsdash.add(DashboardIcons(
       'Booked Units',
        Icon(Icons.account_circle_rounded,size: Insets.xxl,color: Colors.grey.shade600,),
        'CH'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.apps,size: Insets.xxl,color: Colors.grey.shade600,),
        'EP'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.location_searching_sharp,size: Insets.xxl,color: Colors.grey.shade600,),
        'LO'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.settings,size: Insets.xxl,color: Colors.grey.shade600,),
        'SE'));
   /* listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.account_circle_rounded,size: Insets.xl,),
        'BU'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.account_circle_rounded),
        'BU'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.account_circle_rounded),
        'BU'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.account_circle_rounded),
        'BU'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.account_circle_rounded),
        'BU'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.account_circle_rounded),
        'BU'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.account_circle_rounded),
        'BU'));
    listsdash.add(DashboardIcons(
        'Booked Units',
        Icon(Icons.account_circle_rounded),
        'BU'));*/

 }

  }







class DashboardIcons {
  String _name;
  Icon _icon;
 // int _activeIcon;
  String _iconid;

  DashboardIcons(this._name, this._icon, /*this._activeIcon,*/this._iconid);

  String get name => _name;

  set name(String name) => _name = name;

  Icon get icon => _icon;

  set image(Icon icon) => _icon = icon;

 /* int get activeIcon => _activeIcon;

  set activeIcon(int active) => _activeIcon = active;*/

  String get iconId => _iconid;

  set iconid(String image) => _iconid = image;

}