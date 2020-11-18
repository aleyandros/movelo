import 'package:flutter/material.dart';
import 'labels.dart';

class Buttons {
  double _width;
  double _height;

  //Boton amarillo grande
  //Utilizado en:
  //-Los 3 Onboardings
  //-Login
  //-SignUp
  //-Verification
  //-Profile
  //-Panels ( Widget Count() )
  Widget biggestButton({@required text, width, height, Function onPress}) {
    _width = width != null ? _width = width : _width = 314;
    _height = height != null ? _height = height : _height = 50;
    return SizedBox(
      width: _width,
      height: _height,
      child: RaisedButton(
        color: kBlueColour,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        onPressed: onPress,
        child: Text(
          '$text'.toUpperCase(),
          style: kLabelButtonWhite,
        ),
      ),
    );
  }

  //Opcion de retroceder (Sujeto a cambios)
  //Utilizado en:
  //-Grid ( Widget Up() )
  //-Panels ( Widget Count() )
  //-Categories
  //-Destacados
  //-Index
  //-Productos
  //-Profile
  //-SignUp
  //-Verification
  //-Vestimenta
  Widget smallButton({@required icon, color, navigation}) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
        size: 20.0,
      ),
      onPressed: navigation,
    );
  }

  //Boton para editar foto de perfil
  Widget editButton({@required icon, color, navigation}) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
        size: 24.0,
      ),
      onPressed: navigation,
    );
  }

  //Boton de opciones menu hamburguesa
  Widget elementDrawer(
      {@required icon, @required color, @required navigator, @required text}) {
    return Row(
      children: <Widget>[
        smallButton(icon: icon, color: color),
        FlatButton(
          onPressed: navigator,
          child: Text(
            text,
            style: kLabelWhite,
          ),
        ),
      ],
    );
  }
}
