import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hagglex_test/models/user.dart';
import 'package:hagglex_test/router.dart';

User currentUser;

void main() {
  runApp(MyApp(routing: Routing()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Routing routing;
  MyApp({Key key, this.routing}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HaggleX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'BasisGrotesquePro',
        primarySwatch: hagglexColor,
        accentColor: Colors.white
      ),
      onGenerateRoute: routing.generateRoute,
    );
  }

  MaterialColor hagglexColor = const MaterialColor(
    0xFFEA6916,
    const <int, Color>{
      50: const Color(0xFF2E1963),
      100: const Color(0xFF2E1963),
      200: const Color(0xFF2E1963),
      300: const Color(0xFF2E1963),
      400: const Color(0xFF2E1963),
      500: const Color(0xFF2E1963),
      600: const Color(0xFF2E1963),
      700: const Color(0xFF2E1963),
      800: const Color(0xFF2E1963),
      900: const Color(0xFF2E1963),
    },
  );
}
