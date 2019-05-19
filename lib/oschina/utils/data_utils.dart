import 'package:FlutterStudy/oschina/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataUtils {
  static const String SP_ACCESS_TOKEN = 'access_token';
  static const String SP_REFRESH_TOKEN = 'refresh_token';
  static const String SP_UID = 'uid';
  static const String SP_TOKEN_TYPE = 'token_type';
  static const String SP_EXPIRES_IN = 'expires_in';
  static const String SP_IS_LOGIN = 'is_login';

  //用户信息字段
  static const String SP_USER_GENDER = 'gender';
  static const String SP_USER_NAME = 'name';
  static const String SP_USER_LOCATION = 'location';
  static const String SP_USER_ID = 'id';
  static const String SP_USER_AVATAR = 'avatar';
  static const String SP_USER_EMAIL = 'email';
  static const String SP_USER_URL = 'url';

//{"access_token":"aa105aaf-ca4f-4458-822d-1ae6a1fa33f9","refresh_token":"daae8b80-3ca6-4514-a8ae-acb3a82c951c","uid":2006874,"token_type":"bearer","expires_in":510070}
  static Future<void> saveLoginInfo(Map<String, dynamic> map) async {
    if (map != null && map.isNotEmpty) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp
        ..setString(SP_ACCESS_TOKEN, map[SP_ACCESS_TOKEN])
        ..setString(SP_REFRESH_TOKEN, map[SP_REFRESH_TOKEN])
        ..setInt(SP_UID, map[SP_UID])
        ..setString(SP_TOKEN_TYPE, map[SP_TOKEN_TYPE])
        ..setInt(SP_EXPIRES_IN, map[SP_EXPIRES_IN])
        ..setBool(SP_IS_LOGIN, true);
    }
  }

  static Future<void> clearLoginInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp
      ..setString(SP_ACCESS_TOKEN, '')
      ..setString(SP_REFRESH_TOKEN, '')
      ..setInt(SP_UID, -1)
      ..setString(SP_TOKEN_TYPE, '')
      ..setInt(SP_EXPIRES_IN, -1)
      ..setBool(SP_IS_LOGIN, false);
  }

  //是否登录
  static Future<bool> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    return isLogin != null && isLogin;
  }

  //获取token
  static Future<String> getAccessToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(SP_ACCESS_TOKEN);
  }

  //保存用户信息
// {"gender":"male","name":"北极星辰","location":"北京","id":4115462,"avatar":"https://oscimg.oschina.net/oscnet/up-1ua03gnojxauo5dnevtz4nsdfduuydq9.jpg!/both/50x50?t=1555076884000","email":"977cdaf8-250e-4c16-83e3-2bfe3b5dbc65","url":"https://my.oschina.net/u/4115462"}
  static saveUserInfo(Map<String, dynamic> map) async {
    if (map != null && map.isNotEmpty) {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String gender = map[SP_USER_GENDER];
      String name = map[SP_USER_NAME];
      String location = map[SP_USER_LOCATION];
      int id = map[SP_USER_ID];
      String avatar = map[SP_USER_AVATAR];
      String email = map[SP_USER_EMAIL];
      String url = map[SP_USER_URL];
      sp
        ..setString(SP_USER_GENDER, gender)
        ..setString(SP_USER_NAME, name)
        ..setString(SP_USER_LOCATION, location)
        ..setInt(SP_USER_ID, id)
        ..setString(SP_USER_AVATAR, avatar)
        ..setString(SP_USER_EMAIL, email)
        ..setString(SP_USER_URL, url);
      User user = new User(
          id: id,
          name: name,
          gender: gender,
          avatar: avatar,
          email: email,
          location: location,
          url: url);
      return user;
    }
    return null;
  }

  //获取用户信息
  static Future<User> getUserInfo() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool(SP_IS_LOGIN);
    if (isLogin == null || !isLogin) {
      return null;
    }
    User user = new User();
    user.gender = sp.getString(SP_USER_GENDER);
    user.name = sp.getString(SP_USER_NAME);
    user.location = sp.getString(SP_USER_LOCATION);
    user.id = sp.getInt(SP_USER_ID);
    user.avatar = sp.getString(SP_USER_AVATAR);
    user.email = sp.getString(SP_USER_EMAIL);
    user.url = sp.getString(SP_USER_URL);
    return user;
  }
}
