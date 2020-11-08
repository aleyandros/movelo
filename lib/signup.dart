import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movelo/Constants/buttons.dart';
import 'package:movelo/login.dart';
import 'package:movelo/index.dart';
//import 'package:upper/Screens/verification.dart';
import 'package:movelo/Constants/labels.dart';
import 'package:movelo/Constants/inputs.dart';

class Signup extends StatefulWidget {
  static final id = "signup";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  Inputs inp = Inputs();
  Buttons but = Buttons();
  String _nombre;
  String _apellido;
  String _pass1;
  String _pass2;
  String _celular;
  String _email;
  String _backendError = "";
  RegExp validacion =
      new RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
  RegExp validacionEmail = new RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: kBlueColour,
          leading: but.smallButton(
            icon: Icons.arrow_back_ios,
            color: kWhiteColour,
            navigation: () {
              Navigator.pushNamed(context, Login.id);
            },
          ),
          title: Center(
            child: Text(
              'Regístrate',
              style: kLabelTitleWhite,
            ),
          ),
          actions: <Widget>[
            but.smallButton(
              icon: Icons.store,
              color: kBlueColour,
              navigation: () {
                Navigator.pushNamed(context, Index.id);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            color: kBlueColour,
            child: Column(
              children: <Widget>[
                Visibility(
                  visible: _backendError.isNotEmpty,
                  child: Text(
                    _backendError,
                    style: kLabelWhite,
                  ),
                ),
                Expanded(
                  flex: kCenterUpGrid,
                  child: Container(
                    color: kBlueColour,
                  ),
                ),
                Expanded(
                  flex: kCenterBottomGrid,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      Card(
                        elevation: 3,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                          color: kWhiteColour,
                          width: 374,
                          child: Form(
                            key: _formKey,
                            autovalidate: false,
                            onChanged: () {
                              Form.of(primaryFocus.context).save();
                            },
                            child: ListView(
                              /*mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,*/
                              children: <Widget>[
                                inp.dividerElements2(),
                                inp.textForm("Nombre"),
                                inp.inputForm(
                                    description: "Tu nombre",
                                    correction: "Escribe tu nombre",
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "Escribe tu nombre";
                                      }
                                      return null;
                                    },
                                    onSave: (value) {
                                      _nombre = value;
                                    }),
                                inp.dividerElements2(),
                                inp.textForm("Apellido"),
                                inp.inputForm(
                                    description: "Tu apellido",
                                    correction: "Escribe tu apellido",
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "Escribe tu apellido";
                                      }
                                      return null;
                                    },
                                    onSave: (value) {
                                      _apellido = value;
                                    }),
                                inp.dividerElements2(),
                                inp.textForm("Correo electrónico"),
                                inp.inputForm(
                                    keyboard: TextInputType.emailAddress,
                                    description: "Correo electrónico",
                                    correction: "ex: upper@mail.co",
                                    validate: (String value) {
                                      bool temp =
                                          validacionEmail.hasMatch(value);

                                      if (value.isEmpty) {
                                        return "Escribe tu correo";
                                      } else if (!temp) {
                                        return "Ingrese un correo valido.";
                                      }
                                      return null;
                                    },
                                    onSave: (value) {
                                      _email = value;
                                    }),
                                inp.dividerElements2(),
                                inp.textForm("Celular"),
                                inp.inputForm(
                                    keyboard: TextInputType.numberWithOptions(),
                                    description: "(000)-000-00-00",
                                    correction: "No valido",
                                    validate: (String value) {
                                      if (value.isEmpty) {
                                        return "Ingresa unnumero de celular";
                                      }
                                      return null;
                                    },
                                    onSave: (value) {
                                      _celular = value;
                                    }),
                                inp.dividerElements2(),
                                inp.textForm("Contraseña"),
                                inp.inputForm(
                                    obscureText: true,
                                    description: "********",
                                    correction: "No valido",
                                    icon: Icons.lock,
                                    validate: (String value) {
                                      bool temp = validacion.hasMatch(value);
                                      if (!temp) {
                                        return "La contraseña deben contener al menos ocho \ncaracteres, incluyendo al menos 1 letra y 1 número.";
                                      } else {
                                        _pass1 = value;
                                      }
                                      return null;
                                    }),
                                inp.dividerElements2(),
                                inp.textForm("Repetir contraseña"),
                                inp.inputForm(
                                    obscureText: true,
                                    description: "********",
                                    correction: "No son iguales",
                                    icon: Icons.lock,
                                    validate: (value) {
                                      if (value == _pass1) {
                                        _pass2 = value;
                                        return null;
                                      } else {
                                        return "La contraseña no coincide";
                                      }
                                    })
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: -25,
                        child: but.biggestButton(
                          text: 'crear cuenta',
                          onPress: () {},
                        ),
                      ),
                    ],
                    overflow: Overflow.visible,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  flex: kBottomGrid,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '¿Ya tienes cuenta? ',
                        style: kLabelWhite,
                      ),
                      FlatButton(
                        child: Text(
                          'inicia sesión',
                          style: kLabelUnderlineWhite,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
