import 'package:flutter/material.dart';

class HomePageTemp extends StatelessWidget {
  HomePageTemp({Key? key}) : super(key: key);

  final opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinco'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Componentes'),
      ),
      body: ListView(
        children: _crearItemsCorta(),
      ),
    );
  }

  List<Widget> _crearItems() {
    List<Widget> lista = [];

    for (String opcion in opciones) {
      final tempWidget = ListTile(
        title: Text(opcion),
      );

      lista
        ..add(tempWidget)
        ..add(Divider());
    }
    return lista;
  }

  List<Widget> _crearItemsCorta() {
    return opciones.map((item) {
      return Column(
        children: [
          ListTile(
              title: Text(item + '!'),
              subtitle: const Text('Cualquier cosa'),
              leading: const Icon(Icons.account_balance_wallet),
              trailing: const Icon(Icons.keyboard_arrow_right)),
          const Divider()
        ],
      );
    }).toList();
  }
}
