import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Brain {
  Brain({this.origin, this.destiny});

  final LatLng origin;
  final LatLng destiny;

  LatLng getOrigin() {
    return origin;
  }

  LatLng getDestiny() {
    return destiny;
  }
}
