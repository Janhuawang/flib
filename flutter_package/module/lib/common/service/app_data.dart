class AppData {
  static Map<dynamic, dynamic> headers;
  static String source;
  static String userId;
  static String token;
  static String deviceCode;
  static String version;
  static String channel;
  static String ip;
  static bool isDebug = true; // true:debug false: release 默认为false
  static String userName; // 用户名
  static String avatar; // 用户头像
  static bool isAloneDebug = true; // 是否正在用单个Flutter跑

  static setEnv(Map<String, dynamic> env) {
    print('env = ' + env.toString());
    isAloneDebug = false; // 有event数据时说明不是单独调试，有native依赖。
    if (env?.isNotEmpty == true) {
      headers = env["headers"];
      source = headers["source"];
      userId = headers["userId"];
      token = headers["token"];
      version = headers["version"];
      deviceCode = headers["deviceCode"];
      channel = headers["channel"];
      ip = headers["ip"];
      isDebug = env["isDebug"];
      userName = env["userName"];
      avatar = env["avatar"];
    }
  }
}
