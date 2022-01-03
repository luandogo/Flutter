import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intermediate_designs/src/pages/pages.dart';
import 'package:intermediate_designs/src/widgets/drawer_animation.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider(
      create: (context) => DrawerAnimationProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Designs App',
        initialRoute: 'animations',
        routes: {
          'animations': (BuildContext context) => const AnimationsPage(),
          'emergency': (BuildContext context) => const EmergencyPage(),
          'headers': (BuildContext context) => const HeadersPage(),
          'piechart': (BuildContext context) => const PieChartPage(),
          'pinterest': (BuildContext context) => const PinterestPage(),
          'slideshow': (BuildContext context) => const SlideShowPage(),
          'sliverlist': (BuildContext context) => const SliverListPage(),
        },
      ),
    );
  }
}
