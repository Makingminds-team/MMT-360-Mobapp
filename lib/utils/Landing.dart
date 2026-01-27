import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/utils/ApiCalls.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Generic.dart';

class Landing extends ConsumerStatefulWidget {
  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends ConsumerState<Landing> {
  bool _isLoggedIn = false;

  @override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    _route();
  });
}

Future<void> _route() async {
    final isLoggedIn = await getRoutes();
    print("LOGIN STATE: $isLoggedIn");


    if (!mounted) return;

    if (isLoggedIn) {
      final result = await ref.read(refereshTokenProvider.future);

      if (result == true) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/home',
          (route) => false,
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      }
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (route) => false,
      );
    }
  }


  Timer? _refreshTokenTimer;

  Future<void> startRefreshTokenTimer() async {
  final routesData = await getRoutes();
  _isLoggedIn = routesData;

  _refreshTokenTimer?.cancel();
  _refreshTokenTimer = Timer.periodic(
    const Duration(minutes: 25),
    (timer) async {
      if (_isLoggedIn) {
        await ref.read(refereshTokenProvider.future);
      } else {
        stopRefreshTokenTimer();
      }
    },
  );
}


  void stopRefreshTokenTimer() {
    _refreshTokenTimer?.cancel();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                height: 200,
                width: 200,
                'lib/assets/logo.png',
              ),
            ),
            SizedBox(height: 20), // spacing between image and loader
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
