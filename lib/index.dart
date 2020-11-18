import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:movelo/brain.dart';
import 'package:movelo/plants.dart';
import 'package:movelo/Constants/inputs.dart';
import 'package:movelo/Constants/buttons.dart';
import 'package:movelo/Constants/grid.dart';
import 'package:movelo/Constants/labels.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:address_search_text_field/address_search_text_field.dart';
import 'package:geolocator/geolocator.dart';
import 'package:movelo/map.dart';

class Index extends StatefulWidget {
  static final id = "index";

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Inputs inp = Inputs();
  Buttons but = Buttons();
  Grid grid = Grid();
  double lat = 0;
  double lon = 0;
  LatLng fromPoint = LatLng(1, 1);
  LatLng toPoint = LatLng(2, 2);
  LatLng origin;
  LatLng destiny;

  void getLocationLat() async {
    Position position = await Geolocator().getCurrentPosition();
    lat = position.latitude;
    lon = position.longitude;
    origin = LatLng(lat, lon);
  }

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
              navigation: () {
                //Navigator.pushNamed(context, Plants.id);
                getLocationLat();
                print(lat);
                print(lon);
              })
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
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: kWhiteColour,
              child: AddressSearchTextField(
                  country: "Colombia",
                  hintText: "A donde vamos?",
                  onDone: (AddressPoint point) {
                    print(point.latitude);
                    print(point.longitude);
                    destiny = LatLng(point.latitude, point.longitude);

                    Navigator.of(context).pop();
                  },
                  noResultsText: "Busquemos"),
            ),
            SizedBox(
              width: 280,
              height: 50,
              child: RaisedButton(
                color: kBlueColour,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15.0)),
                child: Text(
                  'IR AL NUEVO DESTINO',
                  style: kLabelButtonWhite,
                ),
                onPressed: () {
                  Brain brain = Brain(origin: origin, destiny: destiny);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Map(
                        fromPoint: brain.getOrigin(),
                        toPoint: brain.getDestiny(),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
