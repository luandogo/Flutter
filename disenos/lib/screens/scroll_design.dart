import 'package:flutter/material.dart';

class ScrollScreen extends StatelessWidget {
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.4, 0.6],
          colors: [Color(0xff7AECCB), Color(0xff4FC0DB)]));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: boxDecoration,
      child: PageView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [Page1(), Page2()],
      ),
    ));
  }
}

class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Background Image
      Background(),

      // Main Content
      MainContent()
    ]);
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.topCenter,
      color: const Color(0xff4FC0DB),
      height: double.infinity,
      child: const Image(
        image: AssetImage('assets/scroll-1.png'),
      ),
    );
  }
}

class MainContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 60, fontWeight: FontWeight.bold, color: Colors.white);
    return SafeArea(
      bottom: false,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Text('11°', style: textStyle),
          const Text('Miércoles', style: textStyle),
          Expanded(child: Container()),
          const Icon(Icons.keyboard_arrow_down, size: 100, color: Colors.white)
        ],
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff4FC0DB),
      child: Center(
        child: TextButton(
          onPressed: () => Navigator.pushNamed(context, 'home_screen'),
          // ignore: prefer_const_constructors
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: const Text('Bienvenido',
                style: TextStyle(color: Colors.white, fontSize: 30)),
          ),
          style: TextButton.styleFrom(
              backgroundColor: const Color(0xff0098FA),
              shape: const StadiumBorder()),
        ),
      ),
    );
  }
}
