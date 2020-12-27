import 'http_request.dart';
import 'http_result.dart';

/**
 * http通信抽象层
 */
abstract class HttpAbstract {
  /**
   * 设置请求头
   */
  void setHeaders(Map<String, dynamic> headers);

  /**
   * base url
   */
  void setBaseUrl(String url);

  /**
   * 设置contentType
   */
  void setContentType(String contentType);

  /**
   * 数据返回超时时长 单位毫秒
   */
  void setReceiveTimeout(int receiveTimeout);

  /**
   * 发送数据超时时长 单位毫秒
   */
  void setSendTimeout(int sendTimeout);

  /**
   * 增加拦截器
   */
  void addInterceptors();

  /**
   * 移除拦截器
   */
  void removeInterceptors();

  /**
   * 发送监听器
   */
  void addSendProgressCallback(IProgressCallback sendCallback);

  /**
   * 响应监听器
   */
  void addReceiveProgressCallback(IProgressCallback receiveCallback);

  /**
   * post请求 实现需要异步
   */
  Future<ResultData> post(String url, Map<String, dynamic> body);

  /**
   * get请求
   */
  Future<ResultData> get(String url, Map<String, dynamic> body);
}
