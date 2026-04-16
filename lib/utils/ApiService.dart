

import 'package:flutter/material.dart';
import 'package:makingmindstechnologies_360/config/constantsApi.dart';
import 'package:makingmindstechnologies_360/screens/clients/model/ClientListModel.dart';
import 'package:makingmindstechnologies_360/screens/dashboard/model/DashboardEmployeeSummaryModel.dart';
import 'package:makingmindstechnologies_360/screens/login/model/AdminInfoModel.dart';
import 'package:makingmindstechnologies_360/screens/login/model/LoginModel.dart';
import 'package:makingmindstechnologies_360/screens/projects/model/ProjectModel.dart';
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


  // ADMIN INFO
  Future<AdminInfoModel> adminInfoDetailsApi() async {
    final result =
        await requestPOST(url: ConstantApi.adminInfo, formData: {});

    if (result["success"] == true) {
      print("resultOTP:$result");
      print("resultOTPsss:${result["success"]}");
      return AdminInfoModel?.fromJson(result["response"]);
    } else {
      try {
        var resultval = AdminInfoModel.fromJson(result["response"]);
        // Toast.show(resultval.message.toString(), context);
        print(result["response"]);
        return resultval;
      } catch (e) {
        print(result["response"]);
        // Toast.show(result["response"], context);
      }
    }
    return AdminInfoModel();
  }

  // dashboard summary

  Future<DashboardEmployeeSummaryModel> dasboardSummaryApi() async {
    final result = await requestGET(url: ConstantApi.summaryUrl);
    if (result["success"] == true) {
      print("resultOTP:$result");
      print("resultOTPsss:${result["success"]}");
      return DashboardEmployeeSummaryModel?.fromJson(result["response"]);
    } else {
      try {
        var resultval = DashboardEmployeeSummaryModel.fromJson(result["response"]);
        // Toast.show(resultval.message.toString(), context);
        print(result["response"]);
        return resultval;
      } catch (e) {
        print(result["response"]);
        // Toast.show(result["response"], context);
      }
    }
    return DashboardEmployeeSummaryModel();
  }

  // project list
  Future<List<ProjectModel>> projectListApi() async {
    try {
      final result = await requestGET(url: ConstantApi.projectList);

      if (result["success"] == true) {
        final List<dynamic> list = result["response"] as List<dynamic>;
        return list
            .map((item) => ProjectModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        debugPrint("Project List API failed: ${result["response"]}");
        return [];
      }
    } catch (e, stackTrace) {
      debugPrint("Project List API Error: $e");
      debugPrint("Stack trace: $stackTrace");
      return [];
    }
  }

  // client list

  Future<ClientListModel> clientListApi() async {
    final result = await requestGET(url: ConstantApi.clientList);
    if (result["success"] == true) {
      print("resultOTP:$result");
      print("resultOTPsss:${result["success"]}");
      return ClientListModel?.fromJson(result["response"]);
    } else {
      try {
        var resultval = ClientListModel.fromJson(result["response"]);
        // Toast.show(resultval.message.toString(), context);
        print(result["response"]);
        return resultval;
      } catch (e) {
        print(result["response"]);
        // Toast.show(result["response"], context);
      }
    }
    return ClientListModel();
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
