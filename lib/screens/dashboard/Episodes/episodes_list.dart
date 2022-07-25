import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../../widgets/font_size.dart';
import '../../../widgets/style_insets.dart';
import '../../../widgets/style_space.dart';

class EpisodesList extends StatefulWidget {
  static const routeName = '/episodes';
  const EpisodesList({Key? key}) : super(key: key);

  @override
  State<EpisodesList> createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  List<Episodes> _episodes =[];

  CollectionReference _books = FirebaseFirestore.instance.collection('Books');

  @override
  void initState() {
    super.initState();
    if (_episodes.isNotEmpty) _episodes.clear();

    loadepisodeslist();
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
            'Books',
            style: TextStyles.h3,
          ),
          iconTheme: IconThemeData(color: Colors.black, size: Insets.xl),
        ),
        body: StreamBuilder(
          stream: _books.snapshots(),
          builder: ( context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData){
              return Container(
                padding: EdgeInsets.only(
                    right: Insets.med, left: Insets.med, top: Insets.med),
                child: ListView.builder(
                  itemCount: streamSnapshot.data?.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                    return _buildEpisodes(documentSnapshot);
                  },
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },));
  }

  Widget _buildEpisodes(DocumentSnapshot documentSnapshot) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: Insets.lg, vertical: Insets.med),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(Insets.med)),
          color: Colors.grey.shade300,
          depth: 2.5,
          intensity: 1.5,
        ),
        child: Padding(
          padding:
          EdgeInsets.symmetric(vertical: Insets.sm, horizontal: Insets.sm),
          child:  Container(
            padding: EdgeInsets.symmetric(horizontal: Insets.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(documentSnapshot["name"]),
                VSpace.med,
                Text(documentSnapshot["episode"]),
                VSpace.med,
                Text(documentSnapshot["air_date"]),
              ],
            ),
          )
        ),
      ),
    );
  }


  void loadepisodeslist() {
    _episodes.add(Episodes('https://cdn.britannica.com/60/182360-050-CD8878D6/Avengers-Age-of-Ultron-Joss-Whedon.jpg', "Avengers", "1", "2:30 mints"));
    _episodes.add(Episodes('https://cdn.britannica.com/60/182360-050-CD8878D6/Avengers-Age-of-Ultron-Joss-Whedon.jpg', "Avengers", "2", "2:45 mints"));
    _episodes.add(Episodes('https://cdn.britannica.com/60/182360-050-CD8878D6/Avengers-Age-of-Ultron-Joss-Whedon.jpg', "Avengers", "3", "2:35 mints"));
    _episodes.add(Episodes('https://cdn.britannica.com/60/182360-050-CD8878D6/Avengers-Age-of-Ultron-Joss-Whedon.jpg', "Avengers", "4", "2:15 mints"));
  }
}



class Episodes {
  String _image;
  String _session;
  String _episodes;
  String _duration;
  Episodes(this._image, this._session, this._episodes, this._duration);
}