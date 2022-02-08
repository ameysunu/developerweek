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
  @override
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
            ],
          ),
        ),
      ),
    );
  }
}
