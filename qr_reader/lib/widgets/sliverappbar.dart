import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? assetImage;
  final Color? color;

  const CustomAppBar(
      {Key? key, required this.title, this.assetImage, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.delete_forever))
      ],
      backgroundColor: color ?? Colors.indigoAccent,
      expandedHeight: size.height * 0.25,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
            width: double.infinity,
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
                bottom: size.height * 0.0125,
                left: size.height * 0.025,
                right: size.height * 0.025),
            color: Colors.black12,
            child: Text(
              title,
              style: TextStyle(fontSize: size.height * 0.019),
              textAlign: TextAlign.center,
            )),
        background: Image(
          image: assetImage != null
              ? AssetImage(assetImage!)
              : const AssetImage('assets/loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
