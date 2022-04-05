import 'package:flutter/material.dart';
import 'package:async_button_builder/async_button_builder.dart';

class HomePagePorteria extends StatefulWidget {
  HomePagePorteria({Key key}) : super(key: key);

  @override
  _HomePagePorteriaState createState() => _HomePagePorteriaState();
}

class _HomePagePorteriaState extends State<HomePagePorteria> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Container(),
          title: Text("Ingreso Porteria", style: TextStyle(fontSize: 18)),
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
                            Icons.style_outlined,
                            size: 100,
                          ),
                          SizedBox(height: 5),
                          Text("Búsqueda Manual",
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
  final TextEditingController _folio = new TextEditingController();

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
      title: Text('Búsqueda Manual'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            controller: _rut,
            decoration: const InputDecoration(
              hintText: 'Rut Proveedor: ...',
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
            keyboardType: TextInputType.number,
            style: TextStyle(color: Colors.black, fontSize: 16.0),
            controller: _folio,
            decoration: const InputDecoration(
              hintText: 'Número guía: ...',
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
          child: Text('Búscar'),
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
