import 'package:makingmindstechnologies_360/config/config.dart';

enum Environment { DEV, STAGING, PROD }

class ConstantApi {
  static Map<String, dynamic> _config = Config.debugConstants;
  
  static String loginUrl = SERVER_ONE + "auth/admin_signin/";
  static String adminInfo = SERVER_ONE + "auth/admin_info/";

  // dashboard
  static String summaryUrl = SERVER_ONE + "dashboard/summary/";
  static String projectList = SERVER_ONE + "masters/projectslist/";

  // client
  static String clientList = SERVER_ONE + "masters/clients/";



  

  static String SOMETHING_WRONG = "Some thing wrong";
  static String NO_INTERNET = "No internet Connection";
  static String BAD_RESPONSE = "Bad Response";
  static String UNAUTHORIZED = "Un Athurized";

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = Config.debugConstants;
        break;
      case Environment.STAGING:
        _config = Config.stagingConstants;
        break;
      case Environment.PROD:
        _config = Config.prodConstants;
        break;
    }
  }

  static get SERVER_ONE {
    return _config[Config.SERVER_ONE];
  }

  static get BUILD_VARIANTS {
    return _config[Config.BUILD_VARIANTS];
  }
}


