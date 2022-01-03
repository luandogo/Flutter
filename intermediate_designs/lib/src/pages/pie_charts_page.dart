import 'package:flutter/material.dart';
import 'package:intermediate_designs/src/widgets/drawer_animation.dart';
import 'package:intermediate_designs/src/widgets/widgets.dart';

class PieChartPage extends StatefulWidget {
  const PieChartPage({Key? key}) : super(key: key);

  @override
  State<PieChartPage> createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPage> {
  double percentage = 0;
  @override
  Widget build(BuildContext context) {
    return DrawerAnimation(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadialProgress(
                    percentage: percentage,
                    gradient: const LinearGradient(colors: [
                      Color(0xff09AC9F),
                      Color(0xffFFFF00),
                      Color(0xff00FFFF)
                    ])),
                CustomRadialProgress(
                    percentage: percentage,
                    gradient: const LinearGradient(colors: [
                      Color(0xffC012FF),
                      Color(0xff6D05E8),
                      Color(0xffFF0000)
                    ])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadialProgress(
                  percentage: percentage,
                  gradient: const LinearGradient(colors: [
                    Color(0xffAD308A),
                    Color(0xff05FA83),
                    Color(0xff3345F7)
                  ]),
                ),
                CustomRadialProgress(
                    percentage: percentage, color: Colors.teal),
              ],
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              percentage += 10;
              if (percentage > 100) percentage = 0;
            });
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}

class CustomRadialProgress extends StatelessWidget {
  final Color? color;
  final Color? backColor;
  final double? width;
  final double? backWidth;
  final Gradient? gradient;
  const CustomRadialProgress(
      {Key? key,
      required this.percentage,
      this.color,
      this.backColor,
      this.width,
      this.backWidth,
      this.gradient})
      : super(key: key);

  final double percentage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,

      child: RadialProgress(
          percentage: percentage,
          color: color,
          backColor: backColor,
          width: width,
          backWidth: backWidth,
          gradient: gradient),
      //child: Text('$percentage %', style: TextStyle(fontSize: 50)),
    );
  }
}
