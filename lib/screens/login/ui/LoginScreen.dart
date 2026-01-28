import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:makingmindstechnologies_360/common/Buttons.dart';
import 'package:makingmindstechnologies_360/common/Colors.dart';
import 'package:makingmindstechnologies_360/common/Texts.dart';
import 'package:makingmindstechnologies_360/utils/ApiCalls.dart';
import 'package:makingmindstechnologies_360/utils/Generic.dart';
import 'package:makingmindstechnologies_360/utils/LoadingOverlay.dart';
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
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -100,
            right: -100,
            child: CircleAvatar(radius: 150, backgroundColor: defaultColor.withOpacity(0.05)),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // LOGO SECTION
                      Center(
                        child: Hero(
                          tag: 'logo',
                          child: Image.asset('lib/assets/logo.png', height: 100),
                        ),
                      ),
                      const SizedBox(height: 40),

                      // GREETING
                      Text("Login", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87)),
                      Text("Please sign in to continue", style: TextStyle(fontSize: 16, color: Colors.grey[500])),
                      const SizedBox(height: 40),

                      // USERNAME FIELD
                      _buildInputLabel("Username"),
                      textFormField(
                        hintText: "Enter your username",
                        keyboardtype: TextInputType.text,
                        Controller: _userName,
                        prefixIcon: Icon(Icons.person_outline, color: defaultColor),
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
                          child: Text("Forgot Password?", style: TextStyle(color: defaultColor, fontWeight: FontWeight.w600)),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // LOGIN BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: CommonContainerButton(
                          context, 
                          onPress: _handleLogin, 
                          titleName: 'Sign In'
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      // _buildFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4),
      child: Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
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
    await prefs.setBool('rememberMe', true);
  }
}