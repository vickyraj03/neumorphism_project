import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../widgets/font_size.dart';
import '../../../widgets/style_insets.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String countryValue = '';
  String stateValue = '';
  String cityValue = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Settings',
          style: TextStyles.h3,
        ),
        iconTheme: IconThemeData(color: Colors.black, size: Insets.xl),
      ),
      body: Padding(
        padding:
            EdgeInsets.only(left: Insets.lg, right: Insets.lg, top: Insets.xl),
        child: Column(
          children: [
            Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(Insets.med)),
                  color: Colors.grey.shade200,
                  depth:2.5, // NeumorphicTheme.embossDepth(context),
                  intensity: 1.5,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: Insets.xxl * 3,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: Insets.xxl * 3,
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
