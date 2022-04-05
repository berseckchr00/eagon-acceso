import '/src/pages/home_page_porteria.dart';

import '/src/pages/home_page_casino.dart';

import '/src/pages/home_page_blank.dart';
import '/src/pages/login_page.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/login': (context) => LoginPage(),
    '/home_blank': (BuildContext context) => HomePage(),
    '/home_casino': (BuildContext context) => HomePageCasino(),
    '/home_porteria': (BuildContext context) => HomePagePorteria(),
    '/logout': (BuildContext context) => LoginPage(),
  };
}
