import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:movelo/Constants/inputs.dart';
import 'package:movelo/Constants/buttons.dart';
import 'package:movelo/Constants/grid.dart';
import 'package:movelo/Constants/labels.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movelo/panico.dart';

import 'DirectionProvider.dart';

class Index extends StatefulWidget {
  static final id = "index";
  final LatLng fromPoint = LatLng(4.74203, -74.06652);
  final LatLng toPoint = LatLng(4.8615787, -74.0347255);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  GoogleMapController _mapController;
  Inputs inp = Inputs();
  Buttons but = Buttons();
  Grid grid = Grid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: FontAwesomeIcons.seedling,
            color: kGreenColour,
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
                    style: kLabelMoveloGreen,
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: kRedColour,
        child: Icon(
          Icons.report_problem,
          color: kYellowColor,
          size: 30,
        ),
        onPressed: () {
          Navigator.pushNamed(context, Panico.id);
        },
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Consumer<DirectionProvider>(
              builder:
                  (BuildContext context, DirectionProvider api, Widget child) {
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: widget.fromPoint,
                    zoom: 12,
                  ),
                  markers: _createMarkers(),
                  zoomControlsEnabled: false,
                  polylines: api.currentRoute,
                  onMapCreated: _onMapCreated,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                );
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
              bottom: 15,
              left: 20,
              child: Row(
                children: [
                  SizedBox(
                    width: 130,
                    height: 50,
                    child: RaisedButton(
                      color: kGreenColour,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      child: Text(
                        'CASA',
                        style: kLabelButtonBlue,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 130,
                    height: 50,
                    child: RaisedButton(
                      color: kBlueColour,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      child: Text(
                        'TRABAJO',
                        style: kLabelButtonWhite,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();

    tmp.add(
      Marker(
        markerId: MarkerId("fromPoint"),
        position: widget.fromPoint,
        infoWindow: InfoWindow(title: "Casa"),
      ),
    );
    tmp.add(
      Marker(
        markerId: MarkerId("toPoint"),
        position: widget.toPoint,
        infoWindow: InfoWindow(title: "Trabajo"),
      ),
    );
    return tmp;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;

    _centerView();
  }

  _centerView() async {
    var api = Provider.of<DirectionProvider>(context);

    await _mapController.getVisibleRegion();

    print("buscando direcciones");
    await api.findDirections(widget.fromPoint, widget.toPoint);

    var left = min(widget.fromPoint.latitude, widget.toPoint.latitude);
    var right = max(widget.fromPoint.latitude, widget.toPoint.latitude);
    var top = max(widget.fromPoint.longitude, widget.toPoint.longitude);
    var bottom = min(widget.fromPoint.longitude, widget.toPoint.longitude);

    api.currentRoute.first.points.forEach((point) {
      left = min(left, point.latitude);
      right = max(right, point.latitude);
      top = max(top, point.longitude);
      bottom = min(bottom, point.longitude);
    });

    var bounds = LatLngBounds(
      southwest: LatLng(left, bottom),
      northeast: LatLng(right, top),
    );
    var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 150);
    _mapController.animateCamera(cameraUpdate);
  }
}
