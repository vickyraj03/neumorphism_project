import 'package:shared_preferences/shared_preferences.dart';




class Preferences{

  static const String KEY_USER_ID = "Userid";
  static const String KEY_USR_VALIDATE = 'USERVALIDATE';
  static SharedPreferences ?preferences;

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }


  static void setUserValidate(bool? flag) async {
    preferences?.setBool(KEY_USR_VALIDATE, flag!);
  }

  static bool? getUserValidate() {
    bool? flag = preferences?.getBool(KEY_USR_VALIDATE);
    return flag;
  }


  static void setUserid(String usrid) async {
    preferences?.setString(KEY_USER_ID, usrid);
  }

  static String? getUserid() {
    String? usrid = preferences?.getString(KEY_USER_ID);
    return usrid;
  }}