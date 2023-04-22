import 'package:shared_preferences/shared_preferences.dart';

class AppLocalStorage {
  
  String accessToken = 'token';
  String authorization = 'Authorization';
  String isUserLoggedIn = 'is_user_logged_in';

  saveAccessToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(accessToken, "Bearer $token");
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(accessToken) ?? "";
  }

  saveLoginState(bool boolValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isUserLoggedIn, boolValue);
  }

  Future<bool?> getLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(isUserLoggedIn) != null) {
      return prefs.getBool(isUserLoggedIn);
    } else {
      return false;
    }
  }

  deleteSharedPrefrence() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
