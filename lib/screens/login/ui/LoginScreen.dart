import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/common/Buttons.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/common/Texts.dart';
import 'package:makingmindstechnologies_360/utils/ApiCalls.dart';
import 'package:makingmindstechnologies_360/utils/Generic.dart';
import 'package:makingmindstechnologies_360/utils/LoadingOverlay.dart';
import 'package:makingmindstechnologies_360/common/Styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscurePassword = true;

  void _togglePasswordVisibility() => setState(() => _obscurePassword = !_obscurePassword);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // SUBTLE TOP BRAND ACCENT
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.35,
              decoration: BoxDecoration(
                color: mmColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
              ),
            ),
          ),
          
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGO SECTION
                    Hero(
                      tag: 'logo',
                      child: Column(
                        children: [
                          Image.asset('lib/assets/logo.png', height: 85),
                          const SizedBox(height: 15),
                          Text(
                            "MMT-360",
                            style: TextStyle(
                              fontFamily: fontName,
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 3,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            height: 4,
                            width: 50,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white.withOpacity(0.8), Colors.white.withOpacity(0.2)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),

                    // LOGIN CARD
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 45),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(color: Colors.grey.shade100, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enterprise Login", 
                              style: TextStyle(
                                fontFamily: fontName,
                                fontSize: 26, 
                                fontWeight: FontWeight.bold, 
                                color: Colors.black.withOpacity(0.85),
                                letterSpacing: 0.5,
                              )
                            ),
                            Text(
                              "Internal software access only", 
                              style: TextStyle(
                                fontFamily: fontName,
                                fontSize: 13, 
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.3,
                              )
                            ),
                            const SizedBox(height: 40),

                            // USERNAME FIELD
                            _buildInputLabel("Username"),
                            textFormField(
                              hintText: "Enter your username",
                              keyboardtype: TextInputType.text,
                              Controller: _userName,
                              prefixIcon: Icon(Icons.person_outline, color: mmColor, size: 22),
                              validating: (value) => value!.isEmpty ? 'Please enter your username' : null,
                            ),
                            const SizedBox(height: 25),

                            // PASSWORD FIELD
                            _buildInputLabel("Password"),
                            textFieldPassword(
                              Controller: _password,
                              obscure: _obscurePassword,
                              onPressed: _togglePasswordVisibility,
                              hintText: "Enter your password",
                              keyboardtype: TextInputType.text,
                              validating: (value) => value!.isEmpty ? 'Please enter your password' : null,
                            ),
                            
                            // FORGOT PASSWORD
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Forgot Password?", 
                                  style: TextStyle(
                                    fontFamily: fontName,
                                    color: mmColor, 
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  )
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),

                            // LOGIN BUTTON
                            _buildLoginButton(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return InkWell(
      onTap: _handleLogin,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        height: 58,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [mmColor, mmColor.withOpacity(0.85)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: mmColor.withOpacity(0.35),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGN IN",
              style: TextStyle(
                fontFamily: fontName,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.8,
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, left: 4),
      child: Row(
        children: [
          Icon(label == "Username" ? Icons.alternate_email : Icons.lock_open_rounded, size: 14, color: mmColor.withOpacity(0.7)),
          const SizedBox(width: 6),
          Text(
            label, 
            style: TextStyle(
              fontFamily: fontName,
              fontWeight: FontWeight.w700, 
              color: Colors.black54, 
              fontSize: 14,
              letterSpacing: 0.5,
            )
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account? ", style: TextStyle(color: Colors.grey)),
        GestureDetector(
          onTap: () {},
          child: Text("Sign Up", style: TextStyle(color: defaultColor, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // SAVE FUNCTIONALITY
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      LoadingOverlay.show(context);
      FocusManager.instance.primaryFocus?.unfocus();

      try {
        Map<String, dynamic> formData = {
          "username": _userName.text.trim(),
          "password": _password.text.trim(),
        };

        final result = await ref.read(loginPostProvider(formData).future);
        LoadingOverlay.forcedStop();

        if (result?.success == true) {
          _saveCredentials();
          await accessToken(result?.token);
          await saveUserModel(result!);
          await getToken();
          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
        } else {
          ShowToastMessage(result?.message ?? "Incorrect credentials");
        }
      } catch (e) {
        LoadingOverlay.forcedStop();
        ShowToastMessage("Something went wrong. Please try again.");
      }
    }
  }

  void _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userName', _userName.text);
    await prefs.setString('password', _password.text);
    await prefs.setBool('rememberMe', true);
  }
}