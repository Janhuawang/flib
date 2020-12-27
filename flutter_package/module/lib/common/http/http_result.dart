/**
 * 请求响应的数据体
 *
 */
class ResultData {
  var data;
  String msg;
  int code;
  var headers;

  ResultData(this.data, {this.msg, this.code, this.headers});

  @override
  String toString() {
    return 'ResultData{data: $data, msg: $msg, code: $code, headers: $headers}';
  }
}

// 网络请求错误编码
class Code {
  // 网络请求时除了异常
  static const NETWORK_REQUEST = -1;

  // 网络超时
  static const NETWORK_TIMEOUT = -2;

  // 请求类型问题
  static const NETWORK_METHOD = -3;

  // 成功
  static const SUCCESS = 200;
}
