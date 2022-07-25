import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphism_project/widgets/style_space.dart';

import '../../widgets/font_size.dart';
import '../../widgets/style_insets.dart';

typedef BottomindexCallback = void Function(int val);
typedef Localecallback = void Function();

class Profile extends StatefulWidget {
  final BuildContext? menuScreenContext;
  late bool hideStatus;
  final BottomindexCallback bottomindexCallback;
  final Localecallback localecallback;
  static const routeName = '/profile';
  Profile(
      {Key? key,
      this.menuScreenContext,
      required this.hideStatus,
      required this.bottomindexCallback,
      required this.localecallback})
      : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.withOpacity(0.2),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Profile',
            style: TextStyles.h3,
          ),
          iconTheme: IconThemeData(color: Colors.black, size: Insets.xl),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(Insets.med),
                  decoration: BoxDecoration(
                      image: const DecorationImage(
                        fit: BoxFit.contain,
                        image: ExactAssetImage('assets/images/men.png'),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                          width: Insets.xs - 3, color: Colors.grey.shade600)),
                  height: Insets.xxl * 3,
                  width: Insets.xxl * 3,
                  //  child: Center(child: SvgPicture.asset("assets/images/profile.svg",),)
                ),
              ),
              VSpace.med,
              Text(
                "User Name",
                style: TextStyles.body1,
              ),
              VSpace.xl,
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    HSpace(Insets.xxl + Insets.lg),
                    Expanded(
                        child: Column(
                      children: [
                        Text("120"),
                        Text("Posts"),
                      ],
                    )),
                    HSpace.lg,
                    Expanded(
                        child: Column(
                      children: [
                        Text("120"),
                        Text("Followers"),
                      ],
                    )),
                    HSpace.lg,
                    Expanded(
                        child: Column(
                      children: [
                        Text("120"),
                        Text("Following"),
                      ],
                    )),
                    HSpace(Insets.xxl + Insets.lg),
                  ],
                ),
              ),
              VSpace.med,
              Center(
                child: Container(
                  width: Insets.xxl * 5,
                  height: Insets.xl,
                  //color: Colors.red,
                  child: NeumorphicButton(
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      depth: 2.5,
                      intensity: 1.5,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(Insets.xl)),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                    onPressed: () {
                  /*    Navigator.push(
                        context,
                      *//*  MaterialPageRoute(
                            builder: (context) => OtpScreen(
                                  countrycode: '+91',
                                  mobile: _contactEditingController.text,
                                ))*//*,
                      );*/
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
