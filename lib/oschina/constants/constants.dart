abstract class AppColors {
  //应用主题色
  static const APP_THEME = 0xff63ca6c;
  static const APPBAR = 0xffffffff;
}

abstract class AppInfos {
  static const String CLIENT_ID = "NsGUZ6QLeolZXLqqGpn3";
  static const String CLIENT_SECRET = "fwOBqIojmRGMpgsCZqFJD1FObqZBVhnH";
  static const String REDIRECT_URI = "http://live.sinashow.com";
}

abstract class AppUrls {
  static const String HOST = "https://www.oschina.net";

  //授权登录 ctrl shift u
  static const String OAUTH2_AUTHORIZE = HOST + '/action/oauth2/authorize';

  //获取token
  static const String OAUTH2_TOKEN = HOST + '/action/openapi/token';

  //获取用户信息
  static const String OPENAPI_USER = HOST +  '/action/openapi/user';

  static const String MY_INFORMATION = HOST + '/action/openapi/my_information';
  static const String MESSAGE_LIST = HOST + '/action/openapi/message_list';
}
