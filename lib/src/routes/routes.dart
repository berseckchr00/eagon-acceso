import 'package:eagon_bodega/src/pages/home_page_blank.dart';
import 'package:eagon_bodega/src/pages/login_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (context) => LoginPage(),
    '/home_blank': (BuildContext context) => HomePage(),
    '/logout': (BuildContext context) => LoginPage(),
  };
}
