import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContainerButton extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final Color? color;
  final Color? gradientColor1;
  final Color? gradientColor2;
  final Function? onPress;

  const ContainerButton(
      {Key? key,
      this.icon,
      this.title,
      this.color,
      this.gradientColor1,
      this.gradientColor2,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress;
      },
      child: Stack(
        children: [
          _ContainerButtonBackground(
            icon: icon ?? Icons.language,
            color: color ?? Colors.white,
            gradientColor1: gradientColor1 ?? const Color(0xff6989F5),
            gradientColor2: gradientColor2 ?? const Color(0xff906EF5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 140, width: 40),
              FaIcon(icon ?? Icons.language,
                  color: color ?? Colors.white, size: 40),
              const SizedBox(width: 20),
              Expanded(
                child: Text(
                  title ?? '',
                  style: TextStyle(color: color ?? Colors.white, fontSize: 18),
                ),
              ),
              FaIcon(
                FontAwesomeIcons.chevronRight,
                color: color ?? Colors.white,
              ),
              const SizedBox(width: 40),
            ],
          )
        ],
      ),
    );
  }
}

class _ContainerButtonBackground extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color gradientColor1;
  final Color gradientColor2;

  const _ContainerButtonBackground({
    Key? key,
    required this.icon,
    required this.color,
    required this.gradientColor1,
    required this.gradientColor2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(4, 6),
                blurRadius: 10)
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [gradientColor1, gradientColor2])),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
                right: -20,
                top: -20,
                child: FaIcon(
                  icon,
                  size: 150,
                  color: color.withOpacity(0.2),
                ))
          ],
        ),
      ),
    );
  }
}
