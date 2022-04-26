import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';

import '/src/models/user_model.dart';
import '/src/providers/users_provider.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {'user': null, 'password': null};

  UserModel user = new UserModel();
  UserProvider userProvider = new UserProvider();

  bool submitting = false;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Casino"), value: "Casino"),
      DropdownMenuItem(child: Text("Porteria"), value: "Porteria")
    ];
    return menuItems;
  }

  Map<String, String> routeList = {
    'Porteria': '/home_porteria',
    'Casino': '/home_casino'
  };
  String selectedValue = 'Casino';

  @override
  void initState() {
    super.initState();
  }

  void _toggleSubmitState() {
    setState(() {
      submitting = !submitting;
    });
  }

  @override
  Widget build(BuildContext context) {
    user.origenType = selectedValue;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Control Acceso EAGON'),
          centerTitle: true,
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: false,
        ),
        body: !submitting
            ? _createForm(context)
            : const Center(child: const CircularProgressIndicator()));
  }

  Widget _createForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      child: Image(
                          image: AssetImage(
                              'assets/images/LOGO-EAGON_gris-350x78.png'))),
                ),
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: _createUserInput()),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 15),
                  child: _createPasswordInput()),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 0, bottom: 15),
                  child: _createDropdownOrigin()),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: _createSubmitButton(context))
            ])));
  }

  Widget _createDropdownOrigin() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(2),
          borderSide: BorderSide(color: Colors.grey, width: 0),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(2),
        // ),
        //filled: true,
        contentPadding: EdgeInsets.all(20.0),
      ),
      style: TextStyle(color: Colors.black, fontSize: 20.0),
      value: selectedValue,
      onChanged: (String newValue) {
        setState(() {
          selectedValue = newValue;
          _formData['origen_type'] = newValue;
          user.origenType = newValue;
        });
      },
      items: dropdownItems,
    );
  }

  Widget _createUserInput() {
    return TextFormField(
      initialValue: user.idUser,
      style: TextStyle(color: Colors.black, fontSize: 20.0),
      decoration: const InputDecoration(
        hintText: 'Ingresa tu usuario',
        contentPadding: EdgeInsets.all(20.0),
        isDense: true,
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Usuario Inválido';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['user'] = value;
        user.idUser = value;
        user.user = value;
      },
    );
  }

  Widget _createPasswordInput() {
    return TextFormField(
        initialValue: user.passWord,
        style: TextStyle(color: Colors.black, fontSize: 20.0),
        decoration: const InputDecoration(
          hintText: 'Ingresa tu clave',
          contentPadding: EdgeInsets.all(20.0),
          isDense: true,
        ),
        validator: (value) {
          if (value.isEmpty) {
            return 'Clave Inválida';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['password'] = value;
          user.passWord = value;
          user.pass = value;
        },
        obscureText: true);
  }

  Widget _createSubmitButton(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.orange),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            _submitForm(context);
          }
        },
        child: Text(
          'Ingresar',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ));
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final Future<UserModel> generatedUser = userProvider.getUserLogin(user);

      _toggleSubmitState();

      generatedUser.then((value) => {
            if (value != null)
              {
                if (value.status == 1)
                  {
                    Timer(Duration(seconds: 1), () {
                      Navigator.pushNamed(context, routeList[value.origenType]);
                      _toggleSubmitState();
                    })
                  }
                else
                  {
                    _toggleSubmitState(),
                    Fluttertoast.showToast(
                        msg: "Error al iniciar ${value.msgStatus}",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0)
                  }
              }
            else
              {
                _toggleSubmitState(),
                Fluttertoast.showToast(
                    msg: "Error al iniciar",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0)
              }
          });
    }
  }
}
