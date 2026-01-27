import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:makingmindstechnologies_360/config/constantsApi.dart';
import 'package:makingmindstechnologies_360/utils/Generic.dart';


Future<dynamic> requestGET({required String url}) async {
  try {
    String? accessToken = await getToken();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json; charset=utf-8',
      'Authorization': 'Token $accessToken'
    };

    final response = await http.get(Uri.parse(url), headers: headers);
    final decodedBody =
        utf8.decode(response.bodyBytes); // 👈 Decode properly here

    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseDecode = jsonDecode(decodedBody);
        return {'success': true, 'response': responseDecode};
      case 201:
        final Map<String, dynamic> responseDecode = jsonDecode(decodedBody);
        return {'success': true, 'response': responseDecode};
    
      default:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': false, 'response': responseDecode};
        return jsonResponse;
    }
  } on SocketException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.NO_INTERNET
    };
    return jsonResponse;
  } on FormatException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.BAD_RESPONSE
    };
    return jsonResponse;
  } on HttpException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.SOMETHING_WRONG //Server not responding
    };
    return jsonResponse;
  }
}

Future<dynamic> requestPOST(
    {required String url, required Map<String, dynamic> formData}) async {
  try {
    String? accessToken = await getToken();

    final headers = {
      // 'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Token $accessToken'
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(formData));
    print(response.body);
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        final decodedBody = utf8.decode(response.bodyBytes);

        final Map<String, dynamic> responseDecode = jsonDecode(decodedBody);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      case 201:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
     
      default:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': false, 'response': responseDecode};
        return jsonResponse;
    }
  } on SocketException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.NO_INTERNET
    };
    return jsonResponse;
  } on FormatException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.BAD_RESPONSE
    };
    return jsonResponse;
  } on HttpException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.SOMETHING_WRONG //Server not responding
    };
    return jsonResponse;
  }
}

Future<dynamic> requestPOST2(
    {required String url, required Map<String, dynamic> formData}) async {
  try {
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final response = await http.post(Uri.parse(url),
        body: jsonEncode(formData), headers: headers);

    print(response);
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      case 201:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      default:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': false, 'response': responseDecode};
        return jsonResponse;
    }
  } on SocketException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.NO_INTERNET
    };
    return jsonResponse;
  } on FormatException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.BAD_RESPONSE
    };
    return jsonResponse;
  } on HttpException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.SOMETHING_WRONG //Server not responding
    };
    return jsonResponse;
  }
}

Future<dynamic> requestPOST3(
    {required String url, required Map<String, dynamic> formData}) async {
  try {
    print(url);
    // final headers = {
    //   'Accept': 'application/json',
    //   'Content-Type': 'application/x-www-form-urlencoded',
    //   'Authorization': 'Token $accessToken'
    // };

    final response = await http.post(Uri.parse(url), body: formData);
    print(response);
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      case 201:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      default:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': false, 'response': responseDecode};
        return jsonResponse;
    }
  } on SocketException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.NO_INTERNET
    };
    return jsonResponse;
  } on FormatException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.BAD_RESPONSE
    };
    return jsonResponse;
  } on HttpException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.SOMETHING_WRONG //Server not responding
    };
    return jsonResponse;
  }
}

Future<dynamic> requestPOST4(
    {required String url, required List<Map<String, dynamic>> formData}) async {
  try {
    print(url);
    String? accessToken = await getToken();

    final headers = {
      'Accept': 'application/json',
      // 'Content-Type': 'application/x-www-form-urlencoded',
      'Content-Type': 'application/json',
      'Authorization': 'Token $accessToken'
    };

    final response = await http.post(Uri.parse(url),
        body: jsonEncode(formData), headers: headers);
    print(response);
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      case 201:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      default:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': false, 'response': responseDecode};
        return jsonResponse;
    }
  } on SocketException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.NO_INTERNET
    };
    return jsonResponse;
  } on FormatException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.BAD_RESPONSE
    };
    return jsonResponse;
  } on HttpException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.SOMETHING_WRONG //Server not responding
    };
    return jsonResponse;
  }
}

Future<dynamic> requestPOST5({required String url}) async {
  try {
    String? accessToken = await getToken();

    final headers = {
      // 'Accept': 'application/json',
      // 'Content-Type': 'application/json',
      'Authorization': 'Token $accessToken'
    };

    final response = await http.post(Uri.parse(url), headers: headers);
    print(response.body);
    switch (response.statusCode) {
      case 200:
        final decodedBody = utf8.decode(response.bodyBytes);

        final Map<String, dynamic> responseDecode = jsonDecode(decodedBody);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      case 201:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
   
      default:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': false, 'response': responseDecode};
        return jsonResponse;
    }
  } on SocketException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.NO_INTERNET
    };
    return jsonResponse;
  } on FormatException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.BAD_RESPONSE
    };
    return jsonResponse;
  } on HttpException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.SOMETHING_WRONG //Server not responding
    };
    return jsonResponse;
  }
}

Future<dynamic> requestMultiPart({
  required String url,
  required Map<String, dynamic> formData,
}) async {
  try {
    String? accessToken = await getToken();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer $accessToken'
    };

    final response =
        await http.post(Uri.parse(url), body: formData, headers: headers);
    print(response);
    switch (response.statusCode) {
      case 200:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
      case 201:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': true, 'response': responseDecode};
        return jsonResponse;
    
      default:
        final Map<String, dynamic> responseDecode = jsonDecode(response.body);

        final jsonResponse = {'success': false, 'response': responseDecode};
        return jsonResponse;
    }
  } on SocketException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.NO_INTERNET
    };
    return jsonResponse;
  } on FormatException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.BAD_RESPONSE
    };
    return jsonResponse;
  } on HttpException {
    final jsonResponse = {
      'success': false,
      'response': ConstantApi.SOMETHING_WRONG //Server not responding
    };
    return jsonResponse;
  }
}