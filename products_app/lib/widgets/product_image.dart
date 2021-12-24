import 'dart:io';

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key, this.picture}) : super(key: key);

  final String? picture;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
          width: double.infinity,
          height: 450,
          decoration: _buildBoxDecoration(),
          child: Opacity(
            opacity: 0.9,
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45)),
                child: _GetImage(picture: picture)),
          )),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
          color: Colors.black,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45), topRight: Radius.circular(45)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5))
          ]);
}

class _GetImage extends StatelessWidget {
  const _GetImage({Key? key, this.picture}) : super(key: key);
  final String? picture;

  @override
  Widget build(BuildContext context) {
    if (picture == null) {
      return const Image(
          image: AssetImage('assets/no-image.png'), fit: BoxFit.cover);
    }

    if (picture!.startsWith('http')) {
      return FadeInImage(
        placeholder: const AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(picture!),
        fit: BoxFit.cover,
      );
    }

    return Image.file(
      File(picture!),
      fit: BoxFit.cover,
    );
  }
}
