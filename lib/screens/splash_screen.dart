import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neumorphism_project/widgets/style_insets.dart';
import 'package:neumorphism_project/widgets/style_space.dart';

import 'login_screen/mobilenumber_screen].dart';


class NeumorphismPage extends StatefulWidget {
  const NeumorphismPage({Key? key}) : super(key: key);

  @override
  State<NeumorphismPage> createState() => _NeumorphismPageState();
}

class _NeumorphismPageState extends State<NeumorphismPage> {
  bool _isElevated = true;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:  Column(
          children: [
            VSpace(Insets.xxl*5),
            SvgPicture.asset("assets/images/earthnew.svg",color: Colors.grey,height: Insets.xxl*5,width: Insets.xxl*5,),
            VSpace(Insets.xxl),
            Text("by tapping “Let’s go”, you acknowledge \n that you have read the privacy policy, \n and agree to the terms of services",style: TextStyle(color: Color(0xff525252),fontSize: 14),textAlign: TextAlign.center,strutStyle: StrutStyle(
              height: 1.6
            ),),
            VSpace(Insets.xxl),
            Container(
              width: Insets.xxl*5,
              height: Insets.xl+Insets.lg,
            child:  NeumorphicButton(
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                boxShape: NeumorphicBoxShape.stadium(),
                color: Colors.grey.withOpacity(0.1),
              ),
              //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
              child: Center(
                child: Text(
                  "Let’s Go",
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  MobileNumberScreen()),
                );
              },
            ),
            ),
          /* ,*/

          ],
        ),
      )
    );
  }
}



