import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bees4/theme/theme_helper.dart';
import 'package:bees4/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// This main file initializes the app and serves the starting screen, the login screen
// If the user is already logged in the login screen will serve the dashboard screen 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'bees4',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.loginScreen,
      routes: AppRoutes.routes,
    );
  }
}
