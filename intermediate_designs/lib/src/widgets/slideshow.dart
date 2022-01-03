import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class SlideShow extends StatelessWidget {
  final List<Widget> slides;
  final bool? bottomDots;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? selectedSize;
  final double? unselectedSize;

  const SlideShow({
    Key? key,
    required this.slides,
    this.bottomDots = true,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
    this.selectedSize = 12.0,
    this.unselectedSize = 12.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _SlideShowModel(),
      child: SafeArea(
        child: Center(child: Builder(
          builder: (BuildContext context) {
            Provider.of<_SlideShowModel>(context).selectedColor =
                selectedColor!;
            Provider.of<_SlideShowModel>(context).unselectedColor =
                unselectedColor!;
            Provider.of<_SlideShowModel>(context).selectedSize = selectedSize!;
            Provider.of<_SlideShowModel>(context).unselectedSize =
                unselectedSize!;

            return Column(
              children: [
                if (!bottomDots!) _Dots(dots: slides.length),
                Expanded(child: _Slides(slides: slides)),
                if (bottomDots!) _Dots(dots: slides.length),
              ],
            );
          },
        )),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int dots;
  const _Dots({Key? key, required this.dots}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(dots, (index) => _Dot(index: index)),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;

  const _Dot({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final slideShowModel = Provider.of<_SlideShowModel>(context);
    final bool actualDot = slideShowModel.currentPage >= index - 0.5 &&
        slideShowModel.currentPage < index + 0.5;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: actualDot
          ? slideShowModel.selectedSize
          : slideShowModel.unselectedSize,
      height: actualDot
          ? slideShowModel.selectedSize
          : slideShowModel.unselectedSize,
      decoration: BoxDecoration(
          color: actualDot
              ? slideShowModel.selectedColor
              : slideShowModel.unselectedColor,
          shape: BoxShape.circle),
    );
  }
}

class _Slides extends StatefulWidget {
  final List<Widget> slides;
  const _Slides({Key? key, required this.slides}) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController = PageController();

  @override
  void initState() {
    super.initState();

    pageViewController.addListener(() {
      Provider.of<_SlideShowModel>(context, listen: false).currentPage =
          pageViewController.page!;
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const BouncingScrollPhysics(),
      controller: pageViewController,
      children: widget.slides
          .map((slide) => _Slide(
                child: slide,
              ))
          .toList(),
      // children: [
      //   _Slide(svg: 'assets/svg/slide-1.svg'),
      //   _Slide(svg: 'assets/svg/slide-2.svg'),
      //   _Slide(svg: 'assets/svg/slide-3.svg'),
      // ],
    );
  }
}

class _Slide extends StatelessWidget {
  final Widget child;
  const _Slide({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(30),
        child: child);
  }
}

class _SlideShowModel with ChangeNotifier {
  double _currentPage = 0;
  double get currentPage => _currentPage;
  set currentPage(double currentPage) {
    _currentPage = currentPage;
    notifyListeners();
  }

  Color selectedColor = Colors.blue;

  Color unselectedColor = Colors.grey;

  double selectedSize = 12.0;

  double unselectedSize = 12.0;
}
