import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:neumorphism_project/widgets/style_space.dart';

import '../../../widgets/font_size.dart';
import '../../../widgets/style_insets.dart';
import 'characters_details.dart';

class CharactersList extends StatefulWidget {
  static const routeName = '/charaters';
  CharactersList({Key? key}) : super(key: key);

  @override
  State<CharactersList> createState() => _CharactersListState();
}

class _CharactersListState extends State<CharactersList> {
  CollectionReference _result = FirebaseFirestore.instance.collection('characters');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.95),
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.1),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Characters',
            style: TextStyles.h3,
          ),
          iconTheme: IconThemeData(color: Colors.black, size: Insets.xl),
        ),
        body: StreamBuilder(
          stream: _result.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return Container(
                padding: EdgeInsets.only(
                    right: Insets.med, left: Insets.med, top: Insets.med),
                child: ListView.builder(
                  itemCount: streamSnapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    //Character characters = _characters[index];
                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CharactersDetails(
                                        documentSnapshot: documentSnapshot,
                                      )));
                        },
                        child: _buildCharacters(documentSnapshot));
                  },
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  Widget _buildCharacters(DocumentSnapshot documentSnapshot) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.med),
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
          padding:
              EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.sm),
          child: Row(
            children: [
              Expanded(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(Insets.sm),
                      child: Image.network(documentSnapshot["image"]))),
              HSpace.med,
              Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(documentSnapshot["name"]),
                        VSpace.med,
                        Text(documentSnapshot["species"]),
                        VSpace.med,
                        Text(documentSnapshot["status"]),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
