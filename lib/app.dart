import 'package:crud/product_list_screen.dart';
import 'package:flutter/material.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Crud App",
      theme: _lightThemeData(),
      darkTheme: _darkThemeData(),
      themeMode: ThemeMode.light,
      home: const ProductListScreen(),
    );
  }

  ThemeData _lightThemeData(){
    return ThemeData(
      scaffoldBackgroundColor: Colors.grey.shade300,
      brightness: Brightness.light,

      appBarTheme: const AppBarTheme(
        titleSpacing: 0,
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 6,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.black,
      ),

      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
        errorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.teal,
            foregroundColor: Colors.black),
      ),
    );
  }

  ThemeData _darkThemeData(){
    return ThemeData(
      brightness: Brightness.dark,
      inputDecorationTheme: const InputDecorationTheme(
        enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
        errorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.orange)),
        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),

      appBarTheme: const AppBarTheme(
        titleSpacing: 0,
        centerTitle: true,
        toolbarHeight: 60,
        elevation: 6,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            fixedSize: const Size.fromWidth(double.maxFinite),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.black),
      ),
    );
  }
}