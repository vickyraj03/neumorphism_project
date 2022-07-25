import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/font_size.dart';
import '../../../widgets/style_insets.dart';

class LocationList extends StatefulWidget {
  static const routeName = '/locations';
  const LocationList({Key? key}) : super(key: key);

  @override
  State<LocationList> createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Locations',
          style: TextStyles.h3,
        ),
        iconTheme: IconThemeData(color: Colors.black, size: Insets.xl),
      ),
      body: Container(),
    );
  }
}
