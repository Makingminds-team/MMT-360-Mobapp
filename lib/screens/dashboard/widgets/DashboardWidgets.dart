

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
  Color? color,
}) {
  Color cardColor = color ?? defaultColor;
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: cardColor.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
      border: Border.all(color: cardColor.withOpacity(0.15), width: 1.5),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: cardColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: cardColor, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
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