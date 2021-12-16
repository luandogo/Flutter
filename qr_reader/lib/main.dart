import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/pages.dart';
import 'package:qr_reader/providers/providers.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    //const Color selectedColor = Color.fromRGBO(90, 255, 212, 1);
    //const Color selectedColorOpacity = Color.fromRGBO(90, 255, 212, 0.5);
    // const Color selectedColor = Color.fromRGBO(228, 239, 197, 1);
    const Color selectedColor = Color.fromRGBO(69, 135, 63, 1);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {'home': (_) => HomePage(), 'map': (_) => MapPage()},
        theme: ThemeData.light().copyWith(
            primaryColor: selectedColor,
            appBarTheme: const AppBarTheme(color: selectedColor),
            textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(selectedColor),
            )),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: selectedColor)),
        // ThemeData.dark().copyWith(
        //     primaryColor: selectedColor,
        //     appBarTheme: const AppBarTheme(color: selectedColor),
        //     floatingActionButtonTheme: const FloatingActionButtonThemeData(
        //         backgroundColor: selectedColorOpacity)),
      ),
    );
  }
}
