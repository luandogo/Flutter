import 'package:flutter/material.dart';
import 'package:intermediate_designs/src/widgets/drawer_animation.dart';
import 'package:intermediate_designs/src/widgets/widgets.dart';

class HeadersPage extends StatelessWidget {
  const HeadersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerAnimation(child: const Scaffold(body: GradientWaveHeader()));
  }
}
