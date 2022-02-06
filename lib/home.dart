import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({Key? key, required this.user}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  final firestoreInstance = FirebaseFirestore.instance;
  AsyncSnapshot<DocumentSnapshot>? snapshot;
  Stream<QuerySnapshot>? newStream;
  CollectionReference hospitals =
      FirebaseFirestore.instance.collection('hospital');

  @override
  void initState() {
    super.initState();
    newStream = firestoreInstance.collection('hospital').snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor('#845EC2'),
        title: Text('Home'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Text(widget.user.email.toString()),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text("Therapists near you",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                Flexible(
                  child: StreamBuilder(
                    stream: newStream,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      var totalgroupCount = 0;
                      List<DocumentSnapshot> groupUsers;
                      if (snapshot.hasData) {
                        groupUsers = snapshot.data.docs;
                        totalgroupCount = groupUsers.length;
                        return Container(
                          child: ListView.builder(
                              itemCount: groupUsers.length,
                              itemBuilder: (context, int index) {
                                // return Text(groupUsers[index]['name']);
                                return Card(
                                  color: HexColor("#845EC2"),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
                                            child: Text(
                                                groupUsers[index]['name'],
                                                style: TextStyle(
                                                    fontSize: 25,
                                                    color: Colors.white)),
                                          ),
                                          Text(groupUsers[index]['address'],
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
                ElevatedButton(
                    child: Text("Choose the best one for me"),
                    onPressed: () {
                      _bestClinic();
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _bestClinic() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
