import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphism_project/widgets/style_space.dart';
import 'package:neumorphism_project/widgets/text_style.dart';

import '../../../widgets/font_size.dart';
import '../../../widgets/style_insets.dart';

class CharactersDetails extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;
  CharactersDetails({Key? key,required this.documentSnapshot}) : super(key: key);

  @override
  State<CharactersDetails> createState() => _CharactersDetailsState();
}

class _CharactersDetailsState extends State<CharactersDetails> {
  Color? _statusColor;



  @override
  Widget build(BuildContext context) {
     _statusColor = widget.documentSnapshot["status"] == "Alive"? Colors.green: widget.documentSnapshot["status"] == "Dead"?Colors.red:Colors.grey;
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.95),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Characters Details',
          style: TextStyles.h3,
        ),
        iconTheme: IconThemeData(color: Colors.black, size: Insets.xl),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: Insets.med, left: Insets.med, top: Insets.med),
        child: SingleChildScrollView(
          child: Column(
            children: [
             ClipRRect(
               borderRadius: BorderRadius.circular(Insets.med),
               child: Image.network(widget.documentSnapshot['image']),
             ),
              VSpace.med,
              Text("Information",style: TextStyles.h3,),
              VSpace.med,
              _buildInformation(), VSpace.med,
              Text("Location",style: TextStyles.h3,),
              VSpace.med,
              _buildLocation(),
              VSpace.lg,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInformation(){
    return   Padding(
      padding:  EdgeInsets.symmetric(horizontal: Insets.sm),
      child: Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape:
            NeumorphicBoxShape.roundRect(BorderRadius.circular(Insets.med)),
            color: Colors.grey.shade200,
            depth: 3.5,
            intensity: 3.5,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: Insets.lg,right: Insets.lg,top: Insets.med,bottom: Insets.med),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Insets.med,
                      width: Insets.med,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _statusColor
                      ),
                    ),
                    HSpace.med,
                    textStyle(text: widget.documentSnapshot["status"]),
                  ],
                ),
                VSpace.med,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStyle(text: "Name",style: TextStyles.body1,),
                    textStyle(text: widget.documentSnapshot["name"]),
                  ],
                ),
                _dividerView(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStyle(text: "Species",style: TextStyles.body1,),
                    textStyle(text: widget.documentSnapshot["species"]),
                  ],
                ),
                _dividerView(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStyle(text: "Gender",style: TextStyles.body1,),
                    textStyle(text: widget.documentSnapshot["gender"]),
                  ],
                ),
              ],
            ),
          )
      ),
    );
  }

  Widget _buildLocation(){
    return   Padding(
      padding:  EdgeInsets.symmetric(horizontal: Insets.sm),
      child: Neumorphic(
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape:
            NeumorphicBoxShape.roundRect(BorderRadius.circular(Insets.med)),
            color: Colors.grey.shade200,
            depth: 3.5,
            intensity: 3.5,
          ),
          child: Padding(
            padding: EdgeInsets.only(left: Insets.lg,right: Insets.lg,top: Insets.med,bottom: Insets.med),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStyle(text: "Last Know Location",style: TextStyles.body1,),
                    textStyle(text: widget.documentSnapshot["origin"]["name"]),
                  ],
                ),
                _dividerView(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textStyle(text: "Location",style: TextStyles.body1,),
                    textStyle(text: widget.documentSnapshot["location"]["name"]),
                  ],
                ),

              ],
            ),
          )
      ),
    );
  }

  Widget _dividerView() {
    return  Padding(
      padding: EdgeInsets.only(top: Insets.med,bottom: Insets.med),
      child: Divider(
        height: 1,
        thickness: 1.0,
      ),
    );
  }


}
