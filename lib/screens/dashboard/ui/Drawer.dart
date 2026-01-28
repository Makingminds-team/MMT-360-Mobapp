import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/utils/ApiCalls.dart';

class AppDrawer extends ConsumerWidget { 
  final Function onLogout;
  const AppDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adminInfo = ref.watch(adminInfoProvider);
    
    final adminName = adminInfo.when(
      data: (info) => info?.data?.user?.adminName ?? "User",
      loading: () => "Loading...",
      error: (_, __) => "User",
    );
    
    final adminEmail = adminInfo.when(
      data: (info) => info?.data?.user?.adminEmail ?? "Email",
      loading: () => "Loading...",
      error: (_, __) => "Email",
    );

    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 15, left: 20, right: 20),
            decoration: BoxDecoration(
              color: defaultColor.withOpacity(0.05),
              borderRadius: const BorderRadius.only(topRight: Radius.circular(30)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: defaultColor,
                  child: Text(
                    adminName.isNotEmpty ? adminName[0].toUpperCase() : "U",
                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        adminName, 
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'JosefinSans'), 
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        adminEmail,
                        style: const TextStyle(color: Colors.black54, fontSize: 12, fontWeight: FontWeight.w500, fontFamily: 'JosefinSans'),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // ITEMS
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ListView(
                padding: EdgeInsets.zero, 
                children: [
                  const SizedBox(height: 20), 
                  _buildItem(context, icon: Icons.dashboard_rounded, text: 'Dashboard', isActive: true, onTap: () => Navigator.pop(context)),
                  _buildItem(context, icon: Icons.calendar_month_rounded, text: 'Attendance', onTap: () {}),
                  _buildItem(context, icon: Icons.assignment_rounded, text: 'Leave List', onTap: () {}),
                  _buildItem(context, icon: Icons.account_balance_wallet_rounded, text: 'Payroll', onTap: () {}),
                  const Divider(height: 30, thickness: 1, indent: 10, endIndent: 10),
                  _buildItem(context, icon: Icons.person_outline_rounded, text: 'My Profile', onTap: () {}),
                  _buildItem(
                    context,
                    icon: Icons.logout_rounded, 
                    text: 'Logout', 
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.pop(context); // Close drawer
                      onLogout(); // Call the logout popup
                    }
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap, bool isActive = false, Color? color}) {
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
}