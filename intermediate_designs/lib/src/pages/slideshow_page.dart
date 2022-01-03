import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intermediate_designs/src/widgets/drawer_animation.dart';
import 'package:intermediate_designs/src/widgets/widgets.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerAnimation(
      child: Scaffold(
        body: Column(
          children: const [
            Expanded(child: _MySlideShow()),
            Expanded(child: _MySlideShow()),
          ],
        ),
      ),
    );
  }
}

class _MySlideShow extends StatelessWidget {
  const _MySlideShow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideShow(
        selectedColor: const Color(0xffFF5a7E),
        selectedSize: 15,
        unselectedSize: 5,
        slides: [
          SvgPicture.asset('assets/svg/slide-1.svg'),
          SvgPicture.asset('assets/svg/slide-2.svg'),
          SvgPicture.asset('assets/svg/slide-3.svg'),
          SvgPicture.asset('assets/svg/slide-4.svg'),
          SvgPicture.asset('assets/svg/slide-5.svg')
        ]);
  }
}
