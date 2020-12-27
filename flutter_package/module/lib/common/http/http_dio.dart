import 'package:dio/dio.dart';
import 'package:module/common/bridge/method.dart';
import 'package:module/common/print/print_native.dart';

import 'http_abstract.dart';
import 'http_request.dart';
import 'http_result.dart';

/**
 * dio实现
 */
class HttpDio extends HttpAbstract {
  factory HttpDio() => getInstance();
  static HttpDio _instance;

  static HttpDio getInstance() {
    if (_instance == null) {
      _instance = new HttpDio.internal();
    }
    return _instance;
  }

  final Dio dio = new Dio();

  Options options;
  String baseUrl;
  IProgressCallback sendProgress;
  IProgressCallback receiveProgress;

  HttpDio.internal() {
    options = new Options();
  }

  @override
  void addInterceptors() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      PrintNative.printLog(
          "\n================== 请求数据 ==========================");
      PrintNative.printLog("url = ${options.uri.toString()}");
      PrintNative.printLog("headers = ${options.headers}");
      PrintNative.printLog("params = ${options.data}");
    }, onResponse: (Response response) {
      PrintNative.printLog(
          "\n================== 响应数据 ==========================");
      PrintNative.printLog("code = ${response.statusCode}");
      PrintNative.printLog("headers = ${response.headers}");
      PrintNative.printLog("data = ${response.data}");
      PrintNative.printLog("\n");
    }, onError: (DioError e) {
      PrintNative.printLog(
          "\n================== 错误响应数据 ======================");
      PrintNative.printLog("type = ${e.type}");
      PrintNative.printLog("message = ${e.message}");
      PrintNative.printLog("\n");
    }));
  }

  @override
  void removeInterceptors() {
    // TODO: implement removeInterceptors
  }

  @override
  void setReceiveTimeout(int receiveTimeout) {
    if (options != null) {
      options.receiveTimeout = receiveTimeout;
    }
  }

  @override
  void setSendTimeout(int sendTimeout) {
    if (options != null) {
      options.sendTimeout = sendTimeout;
    }
  }

  @override
  void setHeaders(Map<String, dynamic> headers) {
    if (options != null) {
      options.headers = headers;
    }
  }

  @override
  Future<ResultData> get(String url, Map<String, dynamic> body) async {
    // todo  需要参数拼接一下  /test?id=12&name=chen
    try {
      var response = await dio.get(url,
          queryParameters: body,
          options: options,
          onReceiveProgress: receiveProgress);

      return handlerResponse(response, null);
    } on DioError catch (e) {
      return handlerResponse(e.response, e);
    }
  }

  @override
  Future<ResultData> post(String url, Map<String, dynamic> body) async {
    try {
      var response = await dio.post(url,
          queryParameters: body,
          options: options,
          onSendProgress: sendProgress,
          onReceiveProgress: receiveProgress);

      return handlerResponse(response, null);
    } on DioError catch (e) {
      return handlerResponse(e.response, e);
    }
  }

  @override
  void setBaseUrl(String url) {
    this.baseUrl = url;
  }

  @override
  void setContentType(String contentType) {
    if (options != null) {
      options.contentType = contentType;
    }
  }

  /**
   * 处理数据响应
   */
  Future<ResultData> handlerResponse(Response response, DioError dioError) {
    ResultData resultData;

    if (response != null && response.data != null) {
      if (response.statusCode == 200) {
        Map<String, dynamic> checkMap = response.data;
        if (checkMap != null && "0" != checkMap["code"].toString()) {
          Channel.getInstance().toast("接口错误日志：${checkMap["msg"].toString()}");
        }

        resultData = new ResultData(response.data);
      } else {
        if (response.data is Map) {
          // 打印 {timestamp: 2020-10-30 15:51:16, status: 404, error: Not Found, message: No message available, path: /uc/v1/user/infod}
          Channel.getInstance().toast("接口错误日志：${response.data?.toString()}");

          resultData = new ResultData(response.data,
              code: response.data["status"],
              msg: response.data["message"],
              headers: response.headers);
        }
      }
    } else {
      if (dioError != null) {
        // 一般是本地api用到的问题或域名有问题 Unsupported scheme 'httpd' in URI httpd://dev.esread.com/uc/v1/user/infod}
        Channel.getInstance().toast("请检查您的网络！");

        if (dioError.error is int && dioError.response != null) {
          resultData = new ResultData(dioError.response.data,
              code: dioError.error,
              msg: dioError.message,
              headers: dioError.response.headers);
        }
      }
    }

    if (resultData == null) {
      resultData = new ResultData(null, code: Code.NETWORK_REQUEST);
    }

    PrintNative.printLog("resultData = ${resultData.toString()}");

    return Future.value(resultData);
  }

  @override
  void addSendProgressCallback(sendCallback) {
    this.sendProgress = sendCallback;
  }

  @override
  void addReceiveProgressCallback(receiveCallback) {
    this.receiveProgress = receiveCallback;
  }
}
