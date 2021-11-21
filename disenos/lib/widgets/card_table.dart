import 'dart:ui';

import 'package:flutter/material.dart';

class CardTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      children: const [
        TableRow(children: [
          _SingleCard(
              icon: Icons.border_all, color: Colors.blue, text: 'General'),
          _SingleCard(
              icon: Icons.car_rental, color: Colors.pink, text: 'Transport'),
        ]),
        TableRow(children: [
          _SingleCard(icon: Icons.shop, color: Colors.purple, text: 'Shopping'),
          _SingleCard(
              icon: Icons.cloud, color: Colors.purpleAccent, text: 'Bill'),
        ]),
        TableRow(children: [
          _SingleCard(
              icon: Icons.movie,
              color: Colors.deepPurple,
              text: 'Entertainment'),
          _SingleCard(
              icon: Icons.food_bank_outlined,
              color: Colors.pinkAccent,
              text: 'Grocery'),
        ]),
        TableRow(children: [
          _SingleCard(
              icon: Icons.border_all, color: Colors.blue, text: 'General'),
          _SingleCard(
              icon: Icons.car_rental, color: Colors.pink, text: 'Transport'),
        ]),
      ],
    );
  }
}

class _SingleCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _SingleCard(
      {Key? key, required this.icon, required this.color, required this.text})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return _CardBackground(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: this.color,
          child: Icon(this.icon, size: 35, color: Colors.white),
          radius: 30,
        ),
        const SizedBox(height: 10),
        Text(this.text, style: TextStyle(color: this.color, fontSize: 18))
      ],
    ));
  }
}

class _CardBackground extends StatelessWidget {
  final Widget child;

  const _CardBackground({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final boxDecoration = BoxDecoration(
        color: const Color.fromRGBO(62, 66, 107, 0.7),
        borderRadius: BorderRadius.circular(20));
    return Container(
      margin: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            height: 180,
            decoration: boxDecoration,
            child: this.child,
          ),
        ),
      ),
    );
  }
}
