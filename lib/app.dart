import 'package:cams/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:cams/style/theme.dart' as style;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        restorationScopeId: 'app',
        theme: ThemeData.dark().copyWith(
            textTheme: ThemeData.dark().textTheme.apply(
                  fontFamily: 'Nunito',
                ),
            primaryTextTheme:
                ThemeData.dark().textTheme.apply(fontFamily: 'Nunito'),
            scaffoldBackgroundColor: style.Colors.scaffoldDarkBack,
            splashColor: Colors.black.withOpacity(0.0),
            primaryColorBrightness: Brightness.dark,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: Colors.black,
                selectedItemColor: style.Colors.mainColor,
                selectedIconTheme: IconThemeData(color: style.Colors.mainColor),
                unselectedIconTheme: const IconThemeData(color: Colors.white))),
        home: const MainScreen());
  }
}
