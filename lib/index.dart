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

final double xorigin = 4.74203;
final double yorigin = -74.06652;
final double xend = 4.8615787;
final double yend = -74.0347255;

class Index extends StatefulWidget {
  final LatLng fromPoint = LatLng(xorigin, yorigin);
  final LatLng toPoint = LatLng(xend, yend);
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
    target: LatLng(xorigin, yorigin),
    zoom: 16,
  );

  static final CameraPosition _kLake =
      CameraPosition(target: LatLng(xend, yend), zoom: 16);

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
                markers: _createMarkers(),
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
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

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();

    tmp.add(
        Marker(markerId: MarkerId("fromPoint"), position: widget.fromPoint));
    tmp.add(Marker(markerId: MarkerId("toPoint"), position: widget.toPoint));
    return tmp;
  }
}
