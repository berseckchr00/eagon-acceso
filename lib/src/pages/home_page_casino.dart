import 'dart:developer';
import 'dart:io';

import 'package:eagon_bodega/src/models/access_model.dart';
import 'package:eagon_bodega/src/models/person_model.dart';
import 'package:eagon_bodega/src/models/response_model.dart';
import 'package:eagon_bodega/src/providers/access_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:async_button_builder/async_button_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const QRViewExample(),
                        ));
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

  Future<void> _showMyDialogManual(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (_) => FunkyOverlayManual(),
    );
  }
}

class FunkyOverlayManual extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayStateManual();
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

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  PersonModel personModel = PersonModel();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //TODO: Agregar callback future use API
                  if (result != null)
                    //Text(personModel.rut!)
                    Text(
                        'RUT: ${_getRutfromURI(result.code)} / ${personModel.name}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      //result = scanData;
      setState(() {
        result = scanData;
        _getInfoRut(scanData);
      });
    }).asFuture(_getInfoRut);
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _getInfoRut(Barcode data) async {
    String rut = _getRutfromURI(data.code);
    //TODO: provider call api
    await _getPersonInfo(rut).then((value) => {personModel = value});
    // personModel =
    //     PersonModel(name: 'test', rut: rut, genre: '', direction: '', city: '');

    //print('RUT: ' + personModel.rut);
  }

  String _getRutfromURI(String uri) {
    final regexp = RegExp(r'(\d{8}-\d)');

    // find the first match though you could also do `allMatches`
    final match = regexp.firstMatch(uri);
    return match?.group(0);
  }

  Future<PersonModel> _getPersonInfo(String rut) async {
    AccessProvider acc = AccessProvider();
    PersonModel resp = await acc.getPersonInfo(rut);

    return resp;
  }
}