import 'package:flutter/material.dart';


const String fontName = 'JosefinSans';

TextStyle defaultStyle = const TextStyle(
    fontFamily: fontName,
    fontSize: 24,
    color: Color.fromRGBO(24, 24, 24, 1),
    fontWeight: FontWeight.w700);

Widget headingText(context, {required String Title}) {
  return Container(
    width: MediaQuery.sizeOf(context).width / 1.2,
    child: Text(
      Title,
      style: defaultStyle,
      maxLines: 2,
      textAlign: TextAlign.center,
    ),
  );
}

  Widget titleStyle({required String Title, required bool? isStatus}) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            // width: 135,
            child: Text(
              Title,
              style: defaultStyle,
            ),
          ),
          Text(
            isStatus == true ? "*" : "",
          )
        ],
      ),
    );
  }