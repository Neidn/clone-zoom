import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

import '/utils/colors.dart';

import '/resources/auth_methods.dart';

import '/screens/login_screen.dart';
import '/screens/home_screen.dart';
import '/screens/video_call_screen.dart';

Future<void> initServices(WidgetsBinding widgetsBinding) async {
  print('starting services ...');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('All services started...');
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initServices(widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clone Zoom',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        VideoCallScreen.routeName: (context) => const VideoCallScreen(),
      },
      home: StreamBuilder(
        stream: AuthMethods().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          // Has error
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong!'),
              ),
            );
          }

          // Has data
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          // Default to login screen
          return const LoginScreen();
        },
      ),
    );
  }
}
