import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:makingmindstechnologies_360/screens/dashboard/ui/DashboardScreen.dart';
import 'package:makingmindstechnologies_360/screens/login/ui/LoginScreen.dart';
import 'package:makingmindstechnologies_360/utils/Landing.dart';


void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), 
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          title: "",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: {
            "/": (context) => Landing(),
            "/login": (context) => const LoginScreen(),
            "/home": (context) => DashboardScreen(),
          },
          onGenerateRoute: (value) {
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          },
        );
      },
    );
  }
}
