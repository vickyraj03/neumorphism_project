import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphism_project/screens/dashboard/dashboard.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../settings/preferences.dart';
import '../../widgets/font_size.dart';
import '../../widgets/style_insets.dart';
import '../../widgets/style_space.dart';
import '../Profile.dart';
import '../bottom_nav_screen/bottom_navigation.dart';
import '../utility.dart';

class OtpScreen extends StatefulWidget {
  String countrycode;
  String mobile;
   OtpScreen({Key? key,required this.countrycode, required this.mobile}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  String currentText = "";
  bool isLoading = false;
  String? _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _verifyPhoneNumber();
    print(widget.mobile);
  }



  void _verifyPhoneNumber() async {
    if (mounted)
      setState(() {
        isLoading = true;
      });


    final PhoneVerificationFailed verificationFailed = (FirebaseAuthException authException) {
      Utility.showToast(msg: authException.message);
      print(authException.code);
      print(authException.message);
    };

   /* final PhoneCodeSent codeSent = (String verificationId, [int? forceResendingToken]) async {
      print("codeSent");
      print(verificationId);
      Utility.showToast(
          msg: "Please check your phone for the verification code.");
      _verificationId = verificationId;
    };*/
    final PhoneCodeSent codeSent = (String verificationId, [int? forceResendingToken ]) async{
      print("codeSent");
      print(verificationId);
      Utility.showToast(msg: "Please check your phone for the verification code.");
      _verificationId = verificationId;
    };


    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("codeAutoRetrievalTimeout");
      _verificationId = verificationId;
    };

    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      print("verificationCompleted");
    };


    await _auth.verifyPhoneNumber(
        phoneNumber: widget.countrycode+widget.mobile,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout).then((value) {
          print("then");
    }).catchError((onError){

    });

    /*await _auth.verifyPhoneNumber(
        phoneNumber: widget.countrycode + widget.mobile,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      print("then");
    }).catchError((onError) {
      print(onError);
    });*/
    if (mounted)
      setState(() {
        isLoading = false;
      });

  }


  void _signInWithPhoneNumber(String otp) async {
    _showProgressDialog(true);
    if (await Utility.checkInternet()) {
      try {
        final AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId!,
          smsCode: otp,
        );

        final User? user = (await _auth.signInWithCredential(credential)).user;
        final User? currentUser = _auth.currentUser;
        assert(user?.uid == currentUser?.uid);

        _showProgressDialog(false);
        FirebaseFirestore.instance.collection('Users').doc(user?.uid).get().then((value) {
          if (value.exists) {
            Preferences.setUserid(user!.uid);
            Preferences.setUserValidate(true);
            print('already Exist');
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => BottomNavigatiion(

                )));
          } else {
            print('New User');
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => UserProfileScreen(
                  user: user!,
                  //mobileNumber:   user.phoneNumber!,
                )));
          }
        });
      } catch (e) {
        print(e);
        Utility.showToast(msg: e.toString());
        _showProgressDialog(false);
      }
    } else {
      _showProgressDialog(false);
      Utility.showToast(msg: "No internet connection");
    }
  }

  _showProgressDialog(bool isloadingstate) {
    if (mounted)
      setState(() {
        isLoading = isloadingstate;
      });
  }

  verifyOtp(String otpText) async {
    _signInWithPhoneNumber(otpText);
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
              Padding(
                padding: EdgeInsets.only(left: Insets.xl),
                child: Text(
                  'Now enter the OTP code we \n sent you',
                  style: TextStyles.body1.copyWith(
                      fontSize: FontSizes.s18, fontWeight: FontWeight.w500),
                  strutStyle: StrutStyle(height: 1.8),
                ),
              ),
              VSpace.xl,
              Padding(
                padding: EdgeInsets.only(left: Insets.xl),
                child: Text(
                  'OTP sent on ${widget.countrycode+widget.mobile}',
                  style: TextStyles.body1.copyWith(
                      fontSize: FontSizes.s18, fontWeight: FontWeight.w500),
                  strutStyle: StrutStyle(height: 1.8),
                ),
              ),
              VSpace(Insets.xxl*2),
              Padding(padding: EdgeInsets.symmetric(horizontal: Insets.lg),
            child:   PinCodeTextField(
              appContext: context,
              pastedTextStyle: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              length: 6,
              obscureText: true,
              obscuringCharacter: '*',
              blinkWhenObscuring: true,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 3) {
                  return "I'm from validator";
                } else {
                  return null;
                }
              },
              pinTheme: PinTheme(
                  fieldOuterPadding: EdgeInsets.all(0),
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40,
                  fieldWidth: 30,
                  activeColor:Colors.white,
                  selectedColor:Colors.white,
                  inactiveColor:Colors.white,
                  disabledColor:Colors.white,
                  activeFillColor:Colors.white,
                  selectedFillColor:Colors.white,
                  inactiveFillColor:Colors.white
              ),
              cursorColor: Colors.black,
              animationDuration: const Duration(milliseconds: 300),
              enableActiveFill: true,
              errorAnimationController: errorController,
              controller: textEditingController,
              keyboardType: TextInputType.number,
              boxShadows:  [
                BoxShadow(
                  color: Color(0xFFBEBEBE),
                  // Shadow for bottom right corner
                  offset: Offset(10, 10),
                  blurRadius: 30,
                  spreadRadius: 1,
                  // inset: false,
                ),
                BoxShadow(
                  color: Colors.white,
                  // Shadow for top left corner
                  offset: Offset(-10, -10),
                  blurRadius: 30,
                  spreadRadius: 1,
                  //  inset: false,
                ),
              ],
              onCompleted: (v) {
                debugPrint("Completed");
                verifyOtp(textEditingController.text);
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  currentText = value;
                });
              },
              beforeTextPaste: (text) {
                debugPrint("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),),
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
                      verifyOtp(textEditingController.text);
                      /*Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  OtpScreen(countrycode: '+91', mobile: _c,)),
                      );*/
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


