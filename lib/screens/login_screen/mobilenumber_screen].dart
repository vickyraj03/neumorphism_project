import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphism_project/widgets/app_color.dart';
import 'package:neumorphism_project/widgets/style_insets.dart';
import 'package:neumorphism_project/widgets/style_space.dart';

import '../../widgets/font_size.dart';
import 'otp_Screen.dart';

class MobileNumberScreen extends StatefulWidget {
  const MobileNumberScreen({Key? key}) : super(key: key);

  @override
  State<MobileNumberScreen> createState() => _MobileNumberScreenState();
}

class _MobileNumberScreenState extends State<MobileNumberScreen> {
  final _contactEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              top: Insets.xl + Insets.med, left: Insets.sm, right: Insets.sm),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: Insets.sm),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    height: Insets.xxl,
                    width: Insets.xxl,
                    child: NeumorphicButton(
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        depth: 2.5,
                        intensity: 1.5,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(Insets.lg)),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      //padding: EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                      child: Center(child: Icon(Icons.arrow_back_ios)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              VSpace(Insets.xl),
              Padding(
                padding: EdgeInsets.only(left: Insets.xl),
                child: Text(
                  'I need your phone number to \n know it’s you',
                  style: TextStyles.body1.copyWith(
                      fontSize: FontSizes.s18, fontWeight: FontWeight.w500),
                  strutStyle: StrutStyle(height: 1.8),
                ),
              ),
              VSpace(Insets.xxl*2),
              Row(
               mainAxisAlignment: MainAxisAlignment.center,
               mainAxisSize: MainAxisSize.max,
               children: [
                 Container(
                   height: Insets.xl+Insets.xl,
                   child: Neumorphic(
                       style: NeumorphicStyle(
                           shape: NeumorphicShape.flat,
                           boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(topLeft: Radius.circular(Insets.lg),bottomLeft: Radius.circular(Insets.lg) )),
                           depth: 2.5,
                           intensity: 1.5,
                           color: Colors.grey.withOpacity(0.2)
                       ),
                       child: CountryCodePicker(
                         padding: EdgeInsets.only(left: Insets.xs,right: Insets.xs,top: 0,bottom: 0),
                         onChanged: print,
                         initialSelection: 'IN',
                         showFlagDialog: false,
                         onInit: (code) => print("on init ${code?.name} ${code?.dialCode} ${code?.name}"),
                       ),
                   ),
                 ),
                 Container(
                   height: Insets.xl+Insets.xl,
                   width: Insets.xxl*4,
                 margin: EdgeInsets.symmetric(vertical: Insets.xs),
                   child: Neumorphic(
                       style: NeumorphicStyle(
                           shape: NeumorphicShape.flat,
                           boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(topRight: Radius.circular(Insets.lg),bottomRight: Radius.circular(Insets.lg) )),
                         depth: NeumorphicTheme.embossDepth(context),
                         color: Colors.grey.shade200,

                       ),
                     child: Padding(
                       padding: EdgeInsets.only(left: Insets.med),
                       child: Center(
                         child: TextField(
                           decoration:  InputDecoration(
                             hintText: 'Mobile Number',
                             border: InputBorder.none,
                             enabledBorder: InputBorder.none,
                             focusedBorder: InputBorder.none,
                           ),
                           controller: _contactEditingController,
                           keyboardType: TextInputType.number,
                           textInputAction: TextInputAction.done,
                           inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                         ),
                       ),
                     )
                   ),
                 ),
               ],
             ),
              VSpace(Insets.xxl*2),
            Center(
              child:  Container(
                height: Insets.xxl,
                width: Insets.xxl+Insets.xs,
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
                  child: Center(child: Icon(Icons.arrow_forward_ios)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  OtpScreen(countrycode: '+91', mobile: _contactEditingController.text,)),
                    );
                  },
                ),
              ),
            )
            ],
          ),
        ),
      ),
    );
  }
}
