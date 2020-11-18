import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movelo/index.dart';
import 'package:provider/provider.dart';
import 'package:movelo/Constants/inputs.dart';
import 'package:movelo/Constants/buttons.dart';
import 'package:movelo/Constants/grid.dart';
import 'package:movelo/Constants/labels.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'DirectionProvider.dart';

class Panico extends StatefulWidget {
  static final id = "panico";
  final LatLng fromPoint = LatLng(4.74203, -74.06652);
  final LatLng toPoint = LatLng(4.8615787, -74.0347255);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Panico> {
  GoogleMapController _mapController;
  Inputs inp = Inputs();
  Buttons but = Buttons();
  Grid grid = Grid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kRedColour,
      appBar: AppBar(
        backgroundColor: kBlueColour,
        leading: but.smallButton(
          icon: Icons.arrow_back_ios,
          color: kWhiteColour,
          navigation: () {
            Navigator.pushNamed(context, Index.id);
          },
        ),
        actions: <Widget>[
          but.smallButton(
            icon: Icons.grass,
            color: kGreenColour,
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text(
                  "La ayuda está en camino",
                  style: kLabelTitleYellow,
                ),
              ),
              Icon(
                Icons.report_problem,
                color: kYellowColor,
                size: 250,
              ),
              but.biggestButton(
                text: "Cancelar",
                onPress: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
