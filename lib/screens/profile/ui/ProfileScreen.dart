import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/utils/ApiCalls.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(adminInfoProvider);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: defaultColor,
        elevation: 0,
        title: const Text("My Profile", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: profileAsync.when(
        data: (profileData) {
          final user = profileData?.data?.user;
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(user),
                const SizedBox(height: 20),
                _buildInfoSection(user),
                const SizedBox(height: 20),
                _buildSettingsSection(context),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text("Error: $err")),
      ),
    );
  }

  Widget _buildHeader(dynamic user) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: defaultColor,
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
          ),
        ),
        Positioned(
          top: 30,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              child: Text(
                user?.adminName?[0].toUpperCase() ?? "U",
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: defaultColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoSection(dynamic user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(height: 40), 
          Text(
            user?.adminName ?? "Name not available",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                user?.adminEmail ?? "Email not available",
                style: const TextStyle(color: Colors.grey),
              ),
              if (user?.adminEmailVerified == true)
                const Icon(Icons.verified, color: Colors.blue, size: 16),
            ],
          ),
          const SizedBox(height: 25),
          _profileTile(Icons.person_outline, "Username", user?.username ?? "N/A"),
          _profileTile(Icons.timer_outlined, "Login Expiry", user?.loginExpiry ?? "N/A"),
        ],
      ),
    );
  }

  Widget _buildSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
        ),
        child: Column(
          children: [
            _actionTile(Icons.edit_note_rounded, "Edit Profile", () {}),
            const Divider(height: 1),
            _actionTile(Icons.security_rounded, "Change Password", () {}),
            const Divider(height: 1),
            _actionTile(Icons.help_outline_rounded, "Support Help", () {}),
          ],
        ),
      ),
    );
  }

  Widget _profileTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, color: defaultColor),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}