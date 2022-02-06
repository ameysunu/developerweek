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
  final Set<Marker> markers = new Set();
  LatLng _center = LatLng(51.8833156, -8.5120279);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(51.8833203, -8.5391952),
    zoom: 12.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(51.8833156, -8.5120279),
      tilt: 59.440717697143555,
      zoom: 12.4746);

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
                    markers: getmarkers(),
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
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        label: Text(
          "Choose the best one for me",
          style: TextStyle(color: HexColor('#845EC2')),
        ),
        onPressed: () {
          _bestClinic();
        },
      ),
    );
  }

  Future<void> _bestClinic() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Set<Marker> getmarkers() {
    //markers to place on map
    setState(() {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(LatLng(51.8778744, -8.4773814).toString()),
        position: LatLng(51.8778744, -8.4773814), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'The Sunflower Clinic',
          snippet: 'Tramore Commercial Park, U1, Tramore Rd, Cork, T12 E796',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add second marker
        markerId: MarkerId(LatLng(51.8833156, -8.5120279).toString()),
        position: LatLng(51.8833156, -8.5120279), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Cork University Hospital',
          snippet: 'Wilton Manor, Glasheen, Cork',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      markers.add(Marker(
        //add third marker
        markerId: MarkerId(LatLng(51.8931509, -8.5250969).toString()),
        position: LatLng(51.8931509, -8.5250969), //position of marker
        infoWindow: InfoWindow(
          //popup info
          title: 'Palmer Counselling',
          snippet: '21-23 Oliver Plunkett St, Centre, Cork, T12 NY91',
        ),
        icon: BitmapDescriptor.defaultMarker, //Icon for Marker
      ));

      //add more markers here
    });

    return markers;
  }
}
