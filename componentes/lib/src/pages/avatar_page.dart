import 'package:flutter/material.dart';

class AvatarPage extends StatelessWidget {
  const AvatarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Avatar Page'),
          actions: [
            Container(
              padding: EdgeInsets.all(5.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://i.blogs.es/85aa44/stan-lee/1366_2000.jpg'),
                radius: 30.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 10.0),
              child: CircleAvatar(
                child: Text('SL'),
                backgroundColor: Colors.brown,
              ),
            )
          ],
        ),
        body: Center(
          child: FadeInImage(
              placeholder: AssetImage('assets/jar-loading.gif'),
              fadeInDuration: Duration(milliseconds: 200),
              image: NetworkImage(
                  'https://www.elsoldeacapulco.com.mx/incoming/wpgvi0-villanos-creados-por-stan-lee.jpg/ALTERNATES/LANDSCAPE_1140/Villanos%20creados%20por%20Stan%20lee.jpg')),
        ));
  }
}
