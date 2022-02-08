import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Clinics extends StatefulWidget {
  const Clinics({Key? key}) : super(key: key);

  @override
  _ClinicsState createState() => _ClinicsState();
}

class _ClinicsState extends State<Clinics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#845EC2'),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor('#845EC2'),
        title: Text('Clinics'),
      ),
      body: Container(
        child: Column(
          children: [Text("data")],
        ),
      ),
    );
  }
}
