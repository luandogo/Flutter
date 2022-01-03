import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerAnimation extends StatelessWidget {
  Widget? child;
  DrawerAnimation({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final drawerAnimationProvider =
        Provider.of<DrawerAnimationProvider>(context);

    Color color1 = const Color.fromRGBO(19, 100, 190, 1);
    Color color2 = const Color.fromRGBO(52, 131, 197, 1);
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        SafeArea(
          child: Container(
              width: 200.0,
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                DrawerHeader(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                            radius: 50.0,
                            backgroundImage:
                                AssetImage('assets/jpg/menu-img.jpg')),
                        SizedBox(height: 10.0),
                        Expanded(
                          child: Text(
                            'Itermediate Designs',
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                      ]),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    _MenuOptions(
                        title: 'Animations Page',
                        icon: Icons.home,
                        onTap: () {
                          drawerAnimationProvider.isSelectedMenuOpt = false;
                          drawerAnimationProvider.selectedMenuOpt = 0;
                          Navigator.pushReplacementNamed(context, 'animations');
                        }),
                    _MenuOptions(
                        title: 'Emergency Page',
                        icon: Icons.person,
                        onTap: () {
                          drawerAnimationProvider.isSelectedMenuOpt = false;
                          drawerAnimationProvider.selectedMenuOpt = 0;
                          Navigator.pushReplacementNamed(context, 'emergency');
                        }),
                    _MenuOptions(
                        title: 'Headers Page',
                        icon: Icons.settings,
                        onTap: () {
                          drawerAnimationProvider.isSelectedMenuOpt = false;
                          drawerAnimationProvider.selectedMenuOpt = 0;
                          Navigator.pushReplacementNamed(context, 'headers');
                        }),
                    _MenuOptions(
                        title: 'Pie Chart Page',
                        icon: Icons.logout,
                        onTap: () {
                          drawerAnimationProvider.isSelectedMenuOpt = false;
                          drawerAnimationProvider.selectedMenuOpt = 0;
                          Navigator.pushReplacementNamed(context, 'piechart');
                        }),
                    _MenuOptions(
                        title: 'Pinterest Page',
                        icon: Icons.home,
                        onTap: () {
                          drawerAnimationProvider.isSelectedMenuOpt = false;
                          drawerAnimationProvider.selectedMenuOpt = 0;
                          Navigator.pushReplacementNamed(context, 'pinterest');
                        }),
                    _MenuOptions(
                        title: 'SlideShow Page',
                        icon: Icons.home,
                        onTap: () {
                          drawerAnimationProvider.isSelectedMenuOpt = false;
                          drawerAnimationProvider.selectedMenuOpt = 0;
                          Navigator.pushReplacementNamed(context, 'slideshow');
                        }),
                    _MenuOptions(
                        title: 'Sliver List Page',
                        icon: Icons.home,
                        onTap: () {
                          drawerAnimationProvider.isSelectedMenuOpt = false;
                          drawerAnimationProvider.selectedMenuOpt = 0;
                          Navigator.pushReplacementNamed(context, 'sliverlist');
                        }),
                  ],
                ))
              ])),
        ),
        TweenAnimationBuilder(
            tween: Tween<double>(
                begin: 0, end: drawerAnimationProvider.selectedMenuOpt),
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInExpo,
            builder: (_, double val, __) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..setEntry(0, 3, 200 * val)
                  ..rotateY((pi / 6) * val),
                child: Scaffold(
                  body: Center(
                    child: child,
                  ),
                ),
              );
            }),
        GestureDetector(
          onHorizontalDragUpdate: (e) {
            if (e.delta.dx > 0) {
              drawerAnimationProvider.isSelectedMenuOpt = true;
              drawerAnimationProvider.selectedMenuOpt = 1;
            } else {
              drawerAnimationProvider.isSelectedMenuOpt = false;
              drawerAnimationProvider.selectedMenuOpt = 0;
            }
          },
        )
      ]),
    );
  }
}

class _MenuOptions extends StatelessWidget {
  String title;
  IconData icon;
  dynamic onTap;
  _MenuOptions(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}

class DrawerAnimationProvider extends ChangeNotifier {
  double _selectedMenuOpt = 0;
  double get selectedMenuOpt => _selectedMenuOpt;
  set selectedMenuOpt(double value) {
    _selectedMenuOpt = value;
    notifyListeners();
  }

  bool _isSelectedMenuOpt = false;
  bool get isSelectedMenuOpt => _isSelectedMenuOpt;
  set isSelectedMenuOpt(bool value) {
    _isSelectedMenuOpt = value;
    notifyListeners();
  }
}
