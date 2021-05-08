import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_saving/screens/earnings_screen.dart';
import 'package:money_saving/screens/expenses_screen.dart';

import 'screens/registration_screen.dart';
import 'screens/login_screen.dart';
import 'screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MoneySaving());
}

class MoneySaving extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money Saving',
      theme: ThemeData.dark().copyWith(),
      home: FutureBuilder(
        // Inicjalizacja FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Sprawdzenie czy nie ma errora
          if (snapshot.hasError) {
            return Text('Coś poszło nie tak');
          }

          // Kiedy skończy przełącza się na widok główny aplikacji
          if (snapshot.connectionState == ConnectionState.done) {
            return WelcomeScreen();
          }

          // Wstawić pokrętełko że się coś ładuje
          return Text('Zastąpić paskiem ładowania');
        },
      ),
      // initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ExpenseScreen.id: (context) => ExpenseScreen(),
        EarningsScreen.id: (context) => EarningsScreen(),
      },
    );
  }
}
