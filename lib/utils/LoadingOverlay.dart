import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/common/Styles.dart';
import 'Generic.dart';

class LoadingOverlay {
  static OverlayEntry? _overlayEntry;

  static void show(BuildContext context) {
    if (_overlayEntry == null && SingleTon().isLoading == true) {
      _overlayEntry = OverlayEntry(
        builder: (context) => Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              // BLURRED BACKGROUND
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: Colors.black.withOpacity(0.25),
                  ),
                ),
              ),
              
              // CENTERED LOGO PULSE
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SpinKitDoubleBounce(
                          color: mmColor.withOpacity(0.4),
                          size: 120,
                        ),
                        SpinKitDoubleBounce(
                          color: Colors.white.withOpacity(0.15),
                          size: 150,
                        ),
                        Image.asset(
                          'lib/assets/logo.png',
                          height: 65,
                        ),
                      ],
                    ),
                    const SizedBox(height: 35),
                    Text(
                      "MMT-360",
                      style: TextStyle(
                        fontFamily: fontName,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 3.0,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
      if (_overlayEntry != null) {
        Overlay.of(context).insert(_overlayEntry!);
      }
    }
  }

  static Future<void> hide() async {
    await Future.delayed(
        Duration(seconds: 2)); // Simulate an asynchronous operation

    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null; // Set it to null after removing
    }
  }

  static Future<void> forcedStop() async {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null; // Set it to null after removing
    }
  }
}
