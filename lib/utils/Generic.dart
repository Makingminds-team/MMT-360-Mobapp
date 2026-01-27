import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:makingmindstechnologies_360/screens/login/model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';


// App Name
String appName = 'Making Minds Technologies';

final FlutterSecureStorage _secureStorage = FlutterSecureStorage();
String? accesstokens = 'accessToken';

String? userRole = 'user_role';
String? usercheckIN = 'user_checkin';
String custom_Id = 'id_customer';
String loginModel = 'loginModel';
String Storage = 'storage';
String? routes = "routes_Log";
String phone_no = 'mobile';
String name = 'firstname';
String image = 'image';

AndroidOptions _androidOptions() =>
    AndroidOptions(encryptedSharedPreferences: true);
IOSOptions _getIOSOptions() => IOSOptions(
      accountName: Storage,
    );

void deleteAll() async {
  await _secureStorage.deleteAll(iOptions: _getIOSOptions());
}

accessToken(dynamic val) async {
  await _secureStorage.write(
      key: accesstokens!, value: val, aOptions: _androidOptions());
  print("val!:$val" + "$accesstokens");
}

Future<dynamic> getToken() async {
  final String? gettoken = await _secureStorage.read(
      key: accesstokens!, aOptions: _androidOptions());
  print("valu:$gettoken");
  return gettoken ?? "";
}

Future<void> saveUserModel(LoginModel userModel) async {
  String jsonString = json.encode(userModel.toJson());
  await _secureStorage.write(
      key: loginModel, value: jsonString, aOptions: _androidOptions());
}

Future<LoginModel?> getUserModel() async {
  String? jsonString =
      await _secureStorage.read(key: loginModel, aOptions: _androidOptions());

  if (jsonString != null) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    return LoginModel.fromJson(jsonMap);
  }
  return null; // Return null if no user model is found
}

Future<dynamic> getCustomer_name() async {
  final String? customerName =
      await _secureStorage.read(key: name!, aOptions: _androidOptions());
  print("valu:$customerName");
  return customerName ?? "";
}


Routes(dynamic val) async {
  await _secureStorage.write(
      key: routes!, value: val!, aOptions: _androidOptions());
  print("valuesss:$routes");
  return routes;
}

Future<bool> getRoutes() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn') ?? false;
}


class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}

void ShowToastMessage(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 2,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0);

class GetterSetter {
  String? _myValue;

  String get myValue {
    return _myValue ?? "";
  }

  set myValue(String value) {
    _myValue = value;
  }
}

class SingleTon {
  static final SingleTon qwerty = SingleTon._internal();
  factory SingleTon() {
    return qwerty;
  }
  SingleTon._internal();
  String setLocation = "";
  String lattidue = "";
  String longitude = "";
  bool isLoading = true;
}


extension FirstWhereOrNullExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (E element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
