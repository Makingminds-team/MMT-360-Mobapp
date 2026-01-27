

import 'package:makingmindstechnologies_360/config/constantsApi.dart';
import 'package:makingmindstechnologies_360/screens/login/model/LoginModel.dart';
import 'package:makingmindstechnologies_360/utils/Generic.dart';
import 'package:makingmindstechnologies_360/utils/RequestMethods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  ApiService();

  //LOGIN
  Future<LoginModel> LoginApi(Map<String, dynamic> formData) async {
    final result =await requestPOST3(url: ConstantApi.loginUrl, formData: formData);
    if (result["success"] == true) {
      print("resultOTP:$result");
      print("resultOTPsss:${result["success"]}");

      return LoginModel?.fromJson(result["response"]);
    } else {
      try {
        var resultval = LoginModel.fromJson(result["response"]);
        // Toast.show(resultval.message.toString(), context);
        print(result["response"]);
        return resultval;
      } catch (e) {
        print(result["response"]);
        // Toast.show(result["response"], context);
      }
    }
    return LoginModel();
  }

  Future<bool> refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var formData = <String, dynamic>{
      "username": prefs.getString('userName'),
      "password": prefs.getString('password'),
    };

    final result = await requestPOST2(
        url: ConstantApi.adminInfo, formData: formData);

    if (result["success"] == true) {
      print("resultOTP:$result");
      print("resultOTPsss:${result["success"]}");

      await accessToken(result['response']['token']);
      final getUserData = await getUserModel();
    
      await saveUserModel(getUserData!);

      return true;
    } else {
      try {
        // Toast.show(resultval.message.toString(), context);
        print(result["response"]);
        return false;
      } catch (e) {
        print(result["response"]);
        // Toast.show(result["response"], context);
      }
    }
    return false;
  }

}
