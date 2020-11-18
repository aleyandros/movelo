import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movelo/plants.dart';
import 'package:provider/provider.dart';
import 'package:movelo/Constants/inputs.dart';
import 'package:movelo/Constants/buttons.dart';
import 'package:movelo/Constants/grid.dart';
import 'package:movelo/Constants/labels.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movelo/panico.dart';
import 'package:address_search_text_field/address_search_text_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movelo/index.dart';
import 'DirectionProvider.dart';

class Map extends StatefulWidget {
  static final id = "map";
  final Index ind = Index();
  final LatLng fromPoint = LatLng(4.74203, -74.06652);
  final LatLng toPoint = LatLng(4.8615787, -74.0347255);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Map> {
  GoogleMapController _mapController;
  Inputs inp = Inputs();
  Buttons but = Buttons();
  Grid grid = Grid();
  double lat = 0;
  double lon = 0;

  void getLocationLat() async {
    Position position = await Geolocator().getCurrentPosition();
    lat = position.latitude;
    lon = position.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueColour,
        leading: but.smallButton(
            icon: Icons.arrow_back_ios,
            color: kWhiteColour,
            navigation: () {
              Navigator.pushNamed(context, Index.id);
            }),
        actions: <Widget>[
          but.smallButton(
              icon: FontAwesomeIcons.seedling,
              color: kGreenColour,
              navigation: () {
                Navigator.pushNamed(context, Plants.id);
                getLocationLat();
                print(lat);
                print(lon);
              })
        ],
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
          ],
        ),
      ),
    );
  }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();

    tmp.add(
      Marker(
        visible: false,
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
