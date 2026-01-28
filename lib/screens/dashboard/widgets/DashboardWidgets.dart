

import 'package:flutter/material.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';


void logoutPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Logout",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'JosefinSans',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            "Are you sure you want to logout?",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'JosefinSans',
              fontSize: 14,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'JosefinSans',
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
TextButton(
  onPressed: () async {
    Navigator.pop(context); 
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('userName'); 
    await prefs.remove('password');
    await prefs.setBool('rememberMe', false);

    Navigator.of(context).pushNamedAndRemoveUntil(
      '/login', 
      (route) => false,
    );
  },
  child: const Text(
    "Logout",
    style: TextStyle(
      color: Colors.red,
      fontFamily: 'JosefinSans',
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  ),
),
          ],
        );
      },
    );
  }


Widget buildSummaryCard({
  required String title,
  required String value,
  required IconData icon,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: defaultColor.withOpacity(0.1),
          child: Icon(icon, color: defaultColor, size: 22),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


Widget drawerItem({
  required IconData icon,
  required String text,
  required VoidCallback onTap,
  bool isActive = false,
  Color? color,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    child: ListTile(
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: isActive ? defaultColor.withOpacity(0.1) : Colors.transparent,
      leading: Icon(icon, color: color ?? (isActive ? defaultColor : Colors.grey[700])),
      title: Text(
        text,
        style: TextStyle(
          color: color ?? (isActive ? defaultColor : Colors.black87),
          fontFamily: 'JosefinSans',
          fontSize: 15,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
        ),
      ),
    ),
  );
}