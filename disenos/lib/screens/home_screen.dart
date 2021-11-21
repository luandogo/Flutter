import 'package:flutter/material.dart';

import 'package:disenos/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Background(),

          // Home Body
          _HomeBody(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        // Titulos
        PageTitle(),
        // Card Table
        CardTable(),
      ],
    ));
  }
}
