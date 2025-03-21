import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shiplee/screens/shipping_screen.dart';

void main() {
  runApp(const ShippingApp());
}

// App Theme
// App Theme
// App Theme
class AppTheme {
  static const Color primaryColor = Color(0xFF0D1B2A); // Navy Blue
  static const Color accentColor = Color(0xFF1B263B); // Slightly lighter navy
  static const Color backgroundColor = Colors.white; // White background
  static const Color cardColor = Colors.white; // White for cards
  static const Color textColor = Color(0xFF0D1B2A); // Navy Blue text
  static const Color secondaryTextColor = Color(0xFF4C5C68); // Grayish text
  static const Color successColor = Color(0xFF4CAF50); // Green for success

  static ThemeData get theme => ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: accentColor,
    ),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
      ),
    ),
    cardTheme: CardTheme(
      color: cardColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryColor),
      ),
      labelStyle: TextStyle(color: textColor),
      hintStyle: TextStyle(color: secondaryTextColor),
    ),
  );
}


// Main App
class ShippingApp extends StatelessWidget {
  const ShippingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shipping Calculator',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const ShippingScreen(),
    );
  }
}