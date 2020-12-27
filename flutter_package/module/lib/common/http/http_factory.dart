import 'http_abstract.dart';
import 'http_dio.dart';

class HttpFactory {
  /**
   * 构建一个dio
   */
  static HttpAbstract buildHttpDio() {
    return HttpDio.internal();
  }
}
