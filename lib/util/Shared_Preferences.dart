import 'package:shared_preferences/shared_preferences.dart';
import '';

class authServices {
  static void simpanAkun(String username, String password) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    sharedPref.setString("username", username);
    sharedPref.setString("password", password);

    print(sharedPref.getString("username"));
    print(sharedPref.getString("password"));

  }
  static Future<bool> Login(String username, String password) async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    //validasi login
    if(username == sharedPref.get('username') && password == sharedPref.getString('password')
    ) {
      return true;
    }
    return false;
  }
}
