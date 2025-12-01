import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/vehicle_entry_screen.dart';
import 'screens/vehicle_search_screen.dart';
import 'screens/reports_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'نظام اكسس للنقليات',
      debugShowCheckedModeBanner: false,
      // RTL Support for Arabic
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'AE'), // Arabic
      ],
      locale: const Locale('ar', 'AE'),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
        useMaterial3: true,
        fontFamily: 'Arial', // Fallback font, usually system font works fine
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          filled: true,
          fillColor: Colors.grey.shade50,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/entry': (context) => const VehicleEntryScreen(),
        '/search': (context) => const VehicleSearchScreen(),
        '/reports': (context) => const ReportsScreen(),
      },
    );
  }
}
