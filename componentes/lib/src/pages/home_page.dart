import 'package:flutter/material.dart';

import 'package:componentes/src/providers/menu_provider.dart';

import 'package:componentes/src/utils/icono_string_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: _lista(),
    );
  }

  Widget _lista() {
    // menuProvider.cargarData().then((opciones) {
    //   print('_lista');
    //   print(opciones);
    // });
    return FutureBuilder(
      future: menuProvider.cargarData(),
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return ListView(children: _listaItems(context, snapshot.data));
      },
    );
  }

  List<Widget> _listaItems(BuildContext context, List<dynamic>? data) {
    final List<Widget> opciones = [];

    data?.forEach((opcion) {
      final widgetTemp = ListTile(
        title: Text(opcion['texto']),
        leading: getIcon(opcion['icon']),
        trailing: Icon(Icons.keyboard_arrow_right, color: Colors.blue),
        onTap: () {
          Navigator.pushNamed(context, opcion['ruta']);
          //   final route = MaterialPageRoute(builder: (context) => AlertPage());
          //   Navigator.push(context, route);
        },
      );
      opciones
        ..add(widgetTemp)
        ..add(Divider());
    });
    return opciones;
  }
}
