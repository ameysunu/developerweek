import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Clinics extends StatefulWidget {
  final String clinicName, clinicAddress;
  const Clinics(
      {Key? key, required this.clinicName, required this.clinicAddress})
      : super(key: key);

  @override
  _ClinicsState createState() => _ClinicsState();
}

class _ClinicsState extends State<Clinics> {
  Stream<QuerySnapshot>? newStream;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    newStream = firestoreInstance.collection('therapists').snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#845EC2'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#845EC2'),
        title: Text('Clinics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.clinicName,
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(
                  widget.clinicAddress,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text("Available Therapists",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontStyle: FontStyle.italic)),
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
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Clinics(
                                        clinicName: groupUsers[index]['name'],
                                        clinicAddress: groupUsers[index]
                                            ['address'],
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  color: Colors.white,
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
                                                    color:
                                                        HexColor("#845EC2"))),
                                          ),
                                          Text(groupUsers[index]['rating'],
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: HexColor("#845EC2"),
                                              ))
                                        ],
                                      ),
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
    );
  }
}
