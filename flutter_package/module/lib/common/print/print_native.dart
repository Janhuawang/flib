
import 'package:module/common/service/app_data.dart';

class PrintNative {
  /**
   * 打印日志到native
   */
  static void printLog(String log) {
    if (log != null) {
      if (AppData.isDebug) {
        p(log);
      }
    }
  }

  static void p(String msg) {
    // 因为String的length是字符数量不是字节数量所以为了防止中文字符过多，
    // 把4*1024的MAX字节打印长度改为1000字符数
    int maxStrLength = 1000;
    // 大于1000时
    while (msg.length > maxStrLength) {
      print(msg.substring(0, maxStrLength));
      msg = msg.substring(maxStrLength);
    }
    // 剩余部分
    print(msg);
  }
}
