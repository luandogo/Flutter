import 'package:flutter/material.dart';

class BasicDesignScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Imagen
          Image(image: AssetImage('assets/landscape.jpg')),

          //Titulo
          Title(),

          // Button Section
          ButtonSection(),

          // Descripcion
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
                'Ad id in amet voluptate. Exercitation est deserunt pariatur in. Aliqua commodo aliqua amet consequat aliqua fugiat in exercitation deserunt Lorem. Tempor non quis irure ea aliquip tempor enim esse aute quis. Dolor aliqua nostrud dolor velit velit deserunt ullamco mollit sit consectetur. Mollit adipisicing ullamco irure consequat eiusmod ea est consequat ea deserunt cupidatat do ex do. Voluptate occaecat labore labore elit quis sunt. Minim amet duis et ex exercitation consequat minim. Cillum pariatur velit enim cillum velit eiusmod officia non tempor exercitation esse sunt.'),
          )
        ],
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Oeschinen Lake Campground',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'kandersteg, Switzerland',
                style: TextStyle(color: Colors.black45),
              ),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          Icon(Icons.star, color: Colors.red),
          Text('41')
        ],
      ),
    );
  }
}

class ButtonSection extends StatelessWidget {
  const ButtonSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomButton(icon: Icons.call, text: 'Call'),
          CustomButton(icon: Icons.map_sharp, text: 'Route'),
          CustomButton(icon: Icons.share, text: 'Share'),
          // SizedBox(width: 60),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String text;

  const CustomButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(this.icon, color: Colors.blue, size: 30),
        SizedBox(height: 5),
        Text(
          this.text,
          style: TextStyle(color: Colors.blue, fontSize: 15),
        ),
      ],
    );
  }
}
