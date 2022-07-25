import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/font_size.dart';
import '../../widgets/style_insets.dart';
typedef BottomindexCallback = void Function(int val);
typedef Localecallback = void Function();

class HomePage extends StatefulWidget {final BuildContext? menuScreenContext;
late bool hideStatus;
final BottomindexCallback bottomindexCallback;
final Localecallback localecallback;
static const routeName = '/home';
   HomePage({Key? key,this.menuScreenContext,
     required this.hideStatus,
     required this.bottomindexCallback,
     required this.localecallback}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyles.h3,
        ),
        iconTheme: IconThemeData(color: Colors.black, size: Insets.xl),
      ),
      body: Container(
        child: Center(
          child: Text("Home"),
        ),
      ),
    );
  }
}
