import 'package:eagon_bodega/src/pages/navdrawer_page.dart';
import 'package:eagon_bodega/src/shared_preferences/user_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Map<String, String> _formData = {'rut': null, 'folio': null};
  final _formKey = GlobalKey<FormState>();
  final prefs = new PreferenciasUsuario();
  List<Widget> _cardReception;

  var folioDte = 0;
  var rutDte = "";

  bool submitting = false;

  void _toggleSubmitState() {
    setState(() {
      submitting = !submitting;
    });
  }

  @override
  void initState() {
    super.initState();
    _toggleSubmitState();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
            title: Text('EAGON Bodega'),
            centerTitle: true,
            backgroundColor: Colors.orange
            //leading: Icon(Icons.menu)
            ),
        //body: _createLista(),
        body: (!submitting)
            ? _createHorizontalView(context)
            : const Center(
                child: const CircularProgressIndicator()) //_homeView(),
        );
  }

  Widget _createHorizontalView(context) {
    return Container();
  }
}
