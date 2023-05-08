import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  //keys
  static String userLoggedInKey="LOOGEDINKEY";
  static String userNameKey="USERNAMEKEY";
  static String userEmailKey="USEREMAILKEY";


  //saving data
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sf=await SharedPreferences.getInstance();
    return await sf.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSF(String username) async {
    SharedPreferences sf=await SharedPreferences.getInstance();
    return await sf.setString(userNameKey, username);
  }
  static Future<bool> saveUserEmailSF(String userEmail) async {
    SharedPreferences sf=await SharedPreferences.getInstance();
    return await sf.setString(userEmailKey, userEmail);
  }  


  //getting data
  static Future<bool?> getUSerLoggedInStatus()async{
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
}

