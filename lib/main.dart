import 'package:flutter/material.dart'; // Import Flutter's Material Design package
import 'screens/home_screen.dart'; // Import the HomeScreen widget

/// Main entry point of the application.

/// This function runs the `MyApp` widget, which initializes the entire Flutter app.
void main() {
  runApp(const MyApp()); // Runs the root widget of the app
}

/// **Root widget of the Quote Generator App.**

class MyApp extends StatelessWidget {
  /// **Constructor** for `MyApp` with a `super.key` parameter for widget identification.
  const MyApp({super.key});

  /// Builds the **MaterialApp** for the Flutter application.
  
  /// - A `MaterialApp` widget containing the application structure.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// **Application title** (appears in the task switcher).
      title: 'Quote Generator',

      /// **Global theme of the app**, using a blue color scheme.
      theme: ThemeData(primarySwatch: Colors.blue),

      /// **Initial screen** of the app: HomeScreen.
      home: const HomeScreen(),
    );
  }
}
