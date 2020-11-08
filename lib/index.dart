import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movelo/Constants/buttons.dart';
import 'package:movelo/login.dart';
import 'package:movelo/Constants/labels.dart';
import 'package:movelo/Constants/inputs.dart';
import 'package:movelo/Constants/grid.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movelo/prueba.dart';

class Index extends StatefulWidget {
  static final id = "index";
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Completer<GoogleMapController> _controller = Completer();
  Inputs inp = Inputs();
  Buttons but = Buttons();
  Grid grid = Grid();
  MapSample ms = MapSample();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(4.74203, -74.06652),
    zoom: 15,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(4.8615787, -74.0347255),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlueColour,
          leading: Builder(
            builder: (BuildContext context) {
              return but.smallButton(
                icon: FontAwesomeIcons.bars,
                color: kWhiteColour,
                navigation: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          actions: <Widget>[
            but.smallButton(
              icon: FontAwesomeIcons.phoneAlt,
              color: kWhiteColour,
            )
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: kBlueColour,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: <Widget>[
                DrawerHeader(
                  child: Center(
                    child: Text(
                      "Movelo",
                      style: kLabelUpperYellow,
                    ),
                  ),
                ),
                but.elementDrawer(
                  icon: FontAwesomeIcons.userAlt,
                  color: kWhiteColour,
                  text: "Mi perfil",
                  navigator: () {},
                ),
                but.elementDrawer(
                  icon: FontAwesomeIcons.bicycle,
                  color: kWhiteColour,
                  text: "Bicicletas",
                  navigator: null,
                ),
                but.elementDrawer(
                  icon: FontAwesomeIcons.thumbtack,
                  color: kWhiteColour,
                  text: "Ubicación",
                  navigator: null,
                ),
                but.elementDrawer(
                  icon: FontAwesomeIcons.question,
                  color: kWhiteColour,
                  text: "Ayuda",
                  navigator: null,
                ),
                but.elementDrawer(
                  icon: FontAwesomeIcons.signOutAlt,
                  color: kWhiteColour,
                  text: "Cerrar sesión",
                  navigator: () {},
                ),
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
              Positioned(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: inp.searchBar(text: '¿A dónde vamos?'),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 20,
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: RaisedButton(
                        color: kYellowColour,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                        child: Text(
                          'IR',
                          style: kLabelButtonBlue,
                        ),
                        onPressed: _goToTheLake,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child: RaisedButton(
                        color: kBlueColour,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(15.0)),
                        child: Text(
                          'RUTAS',
                          style: kLabelButtonWhite,
                        ),
                        onPressed: _goToTheLake,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
