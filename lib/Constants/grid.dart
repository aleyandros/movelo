import 'package:flutter/material.dart';
import 'buttons.dart';
import 'labels.dart';
import 'labels.dart';

class Grid {
  Buttons but = Buttons();

  //No utilizado todavia
  Widget appBar({icon1, icon2, color1, color2, navigation1, navigation2, text}) {
    return Expanded(
      flex: kUpGrid,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20.0,
          ),
          but.smallButton(icon: icon1, color: color1, navigation: navigation1),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                text,
                style: kLabelTitleWhite,
              ),
            ),
          ),
          but.smallButton(icon: icon2, color: color2, navigation: navigation2),
          SizedBox(
            width: 30.0,
          ),
        ],
      ),
    );
  }
}
