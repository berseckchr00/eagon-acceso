import 'package:eagon_bodega/src/models/access_model.dart';
import 'package:eagon_bodega/src/models/response_model.dart';
import 'package:eagon_bodega/src/providers/access_provider.dart';
import 'package:flutter/material.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePageCasino extends StatefulWidget {
  HomePageCasino({Key key}) : super(key: key);

  @override
  _HomePageCasinoState createState() => _HomePageCasinoState();
}

class _HomePageCasinoState extends State<HomePageCasino> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text("Ingreso Casino", style: TextStyle(fontSize: 18)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        _showMyDialog(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 1.5,
                      color: Colors.orange.shade300,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.developer_board,
                            size: 100,
                          ),
                          SizedBox(height: 5),
                          Text("Leer Documento",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        _showMyDialogManual(context);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 1.5,
                      color: Colors.grey.shade300,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.input,
                            size: 100,
                          ),
                          SizedBox(height: 5),
                          Text("Ingreso Manual",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) => FunkyOverlay(),
    );
  }

  Future<void> _showMyDialogManual(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) => FunkyOverlayManual(),
    );
  }
}

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayManual extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayStateManual();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  final TextEditingController _otNumber = new TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildAlertDialog();
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text('Lector de Barra'),
      content: TextFormField(
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.black, fontSize: 16.0),
        controller: _otNumber,
        decoration: const InputDecoration(
          hintText: 'Ejemplo: ...',
          contentPadding: EdgeInsets.all(20.0),
          isDense: true,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Error al Leer';
          }
          return null;
        },
        onFieldSubmitted: (String value) {},
      ),
      actions: <Widget>[
        AsyncButtonBuilder(
          child: Text('Validar'),
          onPressed: () async {},
          builder: (context, child, callback, _) {
            return TextButton(
              onPressed: callback,
              child: child,
            );
          },
        ),
        FlatButton(
            child: Text("Cancelar"),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}

class FunkyOverlayStateManual extends State<FunkyOverlayManual>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  final TextEditingController _rut = new TextEditingController();
  final TextEditingController _nombre = new TextEditingController();

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildAlertDialog();
  }

  Widget _buildAlertDialog() {
    return AlertDialog(
      title: Text('Ingreso Manual'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            controller: _rut,
            decoration: const InputDecoration(
              hintText: 'Rut: ...',
              contentPadding: EdgeInsets.all(20.0),
              isDense: true,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Error al Leer';
              }
              return null;
            },
            onFieldSubmitted: (String value) {
              //TODO: buscar DTE
            },
          ),
          TextFormField(
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            controller: _nombre,
            decoration: const InputDecoration(
              hintText: 'Nombre : ...',
              contentPadding: EdgeInsets.all(20.0),
              isDense: true,
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Error al Leer';
              }
              return null;
            },
            onFieldSubmitted: (String value) {
              //TODO: buscar DTE
            },
          )
        ],
      ),
      actions: <Widget>[
        AsyncButtonBuilder(
          child: Text('Ingresar'),
          onPressed: () async {
            if (_nombre.text == "") {
              Fluttertoast.showToast(
                  msg: "Datos Incorrectos",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }

            if (_rut.text == "") {
              Fluttertoast.showToast(
                  msg: "Datos Incorrectos",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }

            if (_rut.text != "" && _nombre.text != "") {
              var data = {
                "rut": _rut.text,
                "name": _nombre.text,
                "user": 'app',
                "location": 'casino'
              };

              AccessModel acc = AccessModel.fromJson(data);
              await _saveAccess(acc).then((value) => {
                    if (value.success || value != null)
                      {
                        Fluttertoast.showToast(
                            msg: "Datos ingresados correctamente",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.green.shade300,
                            textColor: Colors.white,
                            fontSize: 16.0)
                      }
                    else
                      {
                        Fluttertoast.showToast(
                            msg: "Hubo un error",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0)
                      }
                  });
            }
          },
          builder: (context, child, callback, _) {
            return TextButton(
              onPressed: callback,
              child: child,
            );
          },
        ),
        FlatButton(
            child: Text("Cancelar"),
            textColor: Colors.red,
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  Future<ResponseModel> _saveAccess(AccessModel acceso) async {
    AccessProvider acc = AccessProvider();
    ResponseModel resp = await acc.saveAccess(acceso);

    return resp;
  }
}
