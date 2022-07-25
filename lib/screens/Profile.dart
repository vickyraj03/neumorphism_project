import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:flutter_svg/svg.dart';
import 'package:neumorphism_project/screens/dashboard/dashboard.dart';

import '../settings/preferences.dart';
import '../widgets/font_size.dart';
import '../widgets/style_insets.dart';
import '../widgets/style_space.dart';
import 'bottom_nav_screen/bottom_navigation.dart';

class UserProfileScreen extends StatefulWidget {
  User? user;
  //String mobileNumber;
  UserProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  TextEditingController _userNameController = TextEditingController();
  late String mobile;
  late TextEditingController _userMobileController = TextEditingController();
  final TextEditingController _userPincode = TextEditingController();
  final TextEditingController _userGender = TextEditingController();
  bool isUserName = false;
  bool isUserPincode = false;
  bool isUserGender = false;

  @override
  void initState() {
    super.initState();
    // _verifyPhoneNumber();
    _userMobileController = TextEditingController(text: widget.user!.phoneNumber!);

    print(widget.user?.phoneNumber);
  }

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
               Visibility(
                visible: isUserName == false?true:false,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Insets.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                         'Edit Profile' ,
                        style: TextStyles.body1,
                      ),
                      Container(
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
                          child: Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/images/EditSquare.svg',
                            ),
                          ),

                          onPressed: () {
                            setState(() {
                              if (isUserName == true) {
                                isUserName = false;
                              } else {
                                isUserName = true;
                              }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
              VSpace(Insets.xl + Insets.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HSpace.sm,
                  HSpace.sm,
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabled: isUserName,
                        icon: SvgPicture.asset(
                          "assets/images/usericon.svg",
                          height: Insets.lg + Insets.xs,
                        ),
                        isDense: true,
                        isCollapsed: true,
                        hintText: 'Username',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      controller: _userNameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                ],
              ),
              /* VSpace(Insets.xl+Insets.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HSpace.sm,
                  HSpace.sm,
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration:  InputDecoration(
                        icon: SvgPicture.asset("assets/images/Clendar.svg",height: Insets.lg+Insets.xs,),
                        isDense: true,
                        isCollapsed: true,
                        hintText: 'Birthday',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      controller: _userNameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [FilteringTextInputFormatter.singleLineFormatter,],
                    ),
                  ),
                  Expanded(child: SvgPicture.asset('assets/images/EditSquare.svg'))
                ],
              ),*/
              VSpace(Insets.xl + Insets.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HSpace.sm,
                  HSpace.sm,
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabled: isUserName,
                        icon: SvgPicture.asset(
                          "assets/images/pincode.svg",
                          height: Insets.lg + Insets.xs,
                        ),
                        isDense: true,
                        isCollapsed: true,
                        hintText: 'Pincode',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      controller: _userPincode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                ],
              ),
              VSpace(Insets.xl + Insets.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HSpace.sm,
                  HSpace.sm,
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabled: isUserName,
                        icon: SvgPicture.asset(
                          "assets/images/usergender.svg",
                          height: Insets.lg + Insets.xs,
                        ),
                        isDense: true,
                        isCollapsed: true,
                        hintText: 'Gender',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      controller: _userGender,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                ],
              ),
              VSpace(Insets.xl + Insets.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  HSpace.sm,
                  HSpace.sm,
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabled: false,
                        icon: SvgPicture.asset(
                          "assets/images/Vectormobilenumber.svg",
                          height: Insets.lg + Insets.xs,
                        ),
                        isDense: true,
                        isCollapsed: true,
                        hintText: 'Mobile Number',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      // initialValue:'${widget.user?.phoneNumber}',
                      controller: _userMobileController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      inputFormatters: [
                        FilteringTextInputFormatter.singleLineFormatter,
                      ],
                    ),
                  ),
                  // Expanded(child: SvgPicture.asset('assets/images/EditSquare.svg'))
                ],
              ),
              VSpace(Insets.xl+Insets.lg),
              Visibility(
                visible: isUserName == true?true:false,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Insets.xxl,
                      width: Insets.xxl*2,
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
                        child: Center(child: Text('Save',style: TextStyles.body1,textAlign: TextAlign.center),),
                        onPressed: () {
                          setState(() {
                            FirebaseFirestore.instance.collection("Users").doc(widget.user?.uid).set({
                              "userId": widget.user?.uid,
                              "username":_userNameController.text,
                              "usergender":_userGender.text,
                              "Userpincode":_userPincode.text,
                              "mobilenumber": widget.user?.phoneNumber,
                            });
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => BottomNavigatiion(
                                 // user: widget.user!,
                                )));
                            isUserName = false;
                          });
                        },
                      ),
                    ),
                    HSpace(Insets.lg),
                    Container(
                      height: Insets.xxl,
                      width: Insets.xxl*2,
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
                        child: Center(
                          child: Text('Cancel',style: TextStyles.body1,textAlign: TextAlign.center,),
                        ),
                        onPressed: () {
                          setState(() {
                            isUserName = false;

                          });
                        },
                      ),
                    )
                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
