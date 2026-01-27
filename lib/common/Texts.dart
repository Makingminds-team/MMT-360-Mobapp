// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:makingmindstechnologies_360/common/Colors.dart';
// import 'package:makingmindstechnologies_360/common/ImagePath.dart';
// import 'package:makingmindstechnologies_360/common/Styles.dart';


// //TEXTFORM FIELD maks

// Widget textFormField(
//     {TextEditingController? Controller,
//     String? Function(String?)? validating,
//     bool? isEnabled,
//     void Function(String)? onChanged,
//     required String hintText,
//     Widget? prefixIcon,
//     List<TextInputFormatter>? inputFormatters,
//     required TextInputType keyboardtype}) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(color: Colors.grey, width: 1), // White outer border
//     ),
//     child: TextFormField(
//       enabled: isEnabled,
//       controller: Controller,
//       textCapitalization: TextCapitalization.none,
//       inputFormatters: inputFormatters,
//       validator: validating,
//       decoration: InputDecoration(
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//         hintText: hintText,
//         hintStyle: const TextStyle(color: defaultColor),
//         prefixIcon: prefixIcon,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//         // enabledBorder: OutlineInputBorder(
//         //   borderRadius: BorderRadius.circular(5),
//         //   borderSide: const BorderSide(color: defaultColor),
//         // ),
//         fillColor: Colors.white,
//         filled: true,
//       ),
//       onChanged: onChanged,
//       textInputAction: TextInputAction.next,
//       style: TextStyle(
//     fontFamily: fontName,
//     fontSize: 14,
//     color: Color.fromRGBO(0, 0, 0, 1),
//     fontWeight: FontWeight.w500),
//       keyboardType: keyboardtype,
//     ),
//   );
// }

// //TEXTFORMFIELD BORDER
// Widget textFormField_border(
//     {TextEditingController? Controller,
//     String? Function(String?)? validating,
//     bool? isEnabled,
//     void Function(String)? onChanged,
//     required String hintText,
//     Widget? prefixIcon,
//     List<TextInputFormatter>? inputFormatters,
//     required TextInputType keyboardtype}) {
//   return Container(
//     height: 50,
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(color: Colors.grey, width: 1), // White outer border
//       // boxShadow: const [
//       //   BoxShadow(
//       //     color: Colors.black26,
//       //     blurRadius: 5,
//       //     offset: Offset(0, 1),
//       //   ),
//       // ],
//     ),
//     child: TextFormField(
//       enabled: isEnabled,
//       controller: Controller,
//       textCapitalization: TextCapitalization.none,
//       inputFormatters: inputFormatters,
//       validator: validating,
//       decoration: InputDecoration(
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//         hintText: hintText,
//         hintStyle: defaultStyle,
//         prefixIcon: prefixIcon,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//         // enabledBorder: OutlineInputBorder(
//         //   borderRadius: BorderRadius.circular(5),
//         //   borderSide: const BorderSide(color: defaultColor),
//         // ),
//         fillColor: Colors.white,
//         filled: true,
//       ),
//       onChanged: onChanged,
//       textInputAction: TextInputAction.next,
//       style: defaultStyle,
//       keyboardType: keyboardtype,
//     ),
//   );
// }

// // TEXT FIELD PASSWORD
// Widget textFieldPassword(
//     {TextEditingController? Controller,
//     String? Function(String?)? validating,
//     void Function(String)? onChanged,
//     required bool obscure,
//     required void Function()? onPressed,
//     required String hintText,
//     required TextInputType keyboardtype}) {
//   return Container(
//     decoration: BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(color: Colors.grey, width: 1), // White outer border
//     ),
//     child: TextFormField(
//       controller: Controller,
//       obscureText: obscure,
//       validator: validating,
//       decoration: InputDecoration(
//         contentPadding:
//             const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//         hintText: hintText,
//         hintStyle: const TextStyle(color: defaultColor),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide.none,
//         ),
//         // enabledBorder: OutlineInputBorder(
//         //     borderSide: const BorderSide(color: defaultColor),
//         //     borderRadius: BorderRadius.circular(10)),
//         prefixIcon: const Icon(
//           Icons.lock,
//           color: defaultColor,
//         ),
//         suffixIcon: IconButton(
//           icon: obscure
//               ? ImgPathSvg("eyeclose.svg")
//               : const Icon(
//                   Icons.remove_red_eye_outlined,
//                   color: Colors.black,
//                 ),
//           onPressed: onPressed,
//         ),
//         fillColor: Colors.white,
//         filled: true,
//       ),
//       onChanged: onChanged,
//       textInputAction: TextInputAction.next,
//       keyboardType: keyboardtype,
//       style: TextStyle(
//     fontFamily: fontName,
//     fontSize: 14,
//     color: Colors.black,
//     fontWeight: FontWeight.w500),
//     ),
//   );
// }

// Widget textFieldPasswordechange(
//     {TextEditingController? Controller,
//     String? Function(String?)? validating,
//     void Function(String)? onChanged,
//     required bool obscure,
//     required void Function()? onPressed,
//     required String hintText,
//     required TextInputType keyboardtype}) {
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 15),
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.grey, width: 1), // White outer border
//       ),
//       child: TextFormField(
//         controller: Controller,
//         obscureText: obscure,
//         validator: validating,
//         decoration: InputDecoration(
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
//           hintText: hintText,
//           hintStyle: defaultStyle,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide.none,
//           ),
//           // enabledBorder: OutlineInputBorder(
//           //     borderSide: const BorderSide(color: defaultColor),
//           //     borderRadius: BorderRadius.circular(10)),
//           suffixIcon: IconButton(
//             icon: obscure
//                 ? ImgPathSvg("eye.svg")
//                 : const Icon(
//                     Icons.remove_red_eye_outlined,
//                     color: defaultColor,
//                   ),
//             onPressed: onPressed,
//           ),
//           fillColor: Colors.white,
//           filled: true,
//         ),
//         onChanged: onChanged,
//         textInputAction: TextInputAction.next,
//         keyboardType: keyboardtype,
//         style: defaultStyle,
//       ),
//     ),
//   );
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/common/Styles.dart';


BoxDecoration _modernInputBox() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    border: Border.all(color: Colors.grey.shade200, width: 1.5),
  );
}

Widget textFormField({
  TextEditingController? Controller,
  String? Function(String?)? validating,
  bool isEnabled = true,
  void Function(String)? onChanged,
  required String hintText,
  Widget? prefixIcon,
  List<TextInputFormatter>? inputFormatters,
  required TextInputType keyboardtype,
}) {
  return Container(
    decoration: _modernInputBox(),
    child: TextFormField(
      enabled: isEnabled,
      controller: Controller,
      inputFormatters: inputFormatters,
      validator: validating,
      onChanged: onChanged,
      keyboardType: keyboardtype,
      textInputAction: TextInputAction.next,
      style: TextStyle(
        fontFamily: fontName,
        fontSize: 15,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        prefixIcon: prefixIcon != null 
          ? Padding(padding: const EdgeInsets.only(left: 4), child: prefixIcon) 
          : null,
        border: InputBorder.none, // Removes the default underline
        fillColor: Colors.transparent,
        filled: true,
      ),
    ),
  );
}

Widget textFieldPassword({
  TextEditingController? Controller,
  String? Function(String?)? validating,
  void Function(String)? onChanged,
  required bool obscure,
  required void Function()? onPressed,
  required String hintText,
  required TextInputType keyboardtype,
}) {
  return Container(
    decoration: _modernInputBox(),
    child: TextFormField(
      controller: Controller,
      obscureText: obscure,
      validator: validating,
      onChanged: onChanged,
      keyboardType: keyboardtype,
      textInputAction: TextInputAction.done,
      style: const TextStyle(fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
        border: InputBorder.none,
        prefixIcon: Icon(Icons.lock_outline_rounded, color: defaultColor, size: 22),
        suffixIcon: IconButton(
          icon: obscure
              ? Icon(Icons.visibility_off_outlined, color: Colors.grey[400])
              : Icon(Icons.visibility_outlined, color: defaultColor),
          onPressed: onPressed,
        ),
        fillColor: Colors.transparent,
        filled: true,
      ),
    ),
  );
}

Widget textFormField_border({
  TextEditingController? Controller,
  String? Function(String?)? validating,
  required String hintText,
  required TextInputType keyboardtype,
}) {
  return Container(
    height: 55,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: textFormField(
      Controller: Controller,
      validating: validating,
      hintText: hintText,
      keyboardtype: keyboardtype,
    ),
  );
}