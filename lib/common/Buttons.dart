import 'package:flutter/material.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/common/Styles.dart';


Widget CommonElevatedButton(
  BuildContext context,
  String titleName,
  void Function()? onPress,
) {
  return Container(
    width: double.infinity,
    height: 55,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      gradient: LinearGradient(
        colors: [defaultColor, defaultColor.withOpacity(0.8)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      boxShadow: [
        BoxShadow(
          color: defaultColor.withOpacity(0.3),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: onPress,
      child: Text(
        titleName.toUpperCase(),
        style: defaultStyle.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ),
  );
}

Widget CommonContainerButton(context,
    {required void Function()? onPress, required String titleName}) {
  return InkWell(
    onTap: onPress,
    borderRadius: BorderRadius.circular(12),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: 55,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: defaultColor,
        boxShadow: [
          BoxShadow(
            color: defaultColor.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Center(
        child: Text(
          titleName,
          style: TextStyle(
            fontFamily: fontName,
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    ),
  );
}

