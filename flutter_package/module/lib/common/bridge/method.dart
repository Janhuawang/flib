import 'dart:typed_data';

import 'package:module/common/print/print_native.dart';
import 'package:module/common/service/app_data.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/services.dart';

typedef MethodHandle = void Function(Map<String, dynamic> data);

var uuid = new Uuid();

/**
 * 全局通道
 */
class ChannelMethodGlobal<T> {
  String uniqueId = uuid.v4();
  final T data;

  ChannelMethodGlobal(this.data);

  Map<dynamic, dynamic> toJson() {
    return {"uniqueId": uniqueId, "data": data};
  }
}

class ChannelResponse<T> {
  final bool status;
  final int errorCode;
  final T data;

  ChannelResponse({this.status, this.data, this.errorCode});
}

class ChannelMethod {
  static final String METHOD_WECHAT_PAY = "WeChatPayCallback"; // 微信支付结果回调
}

class Channel {
  factory Channel() => getInstance();
  static Channel _instance;

  static Channel getInstance() {
    if (_instance == null) {
      _instance = new Channel.internal();
    }
    return _instance;
  }

  Map<String, MethodHandle> _handleMap = {};

  void addCallHandlerListen(String methodName, MethodHandle methodHandle) {
    _handleMap[methodName] = methodHandle;
  }

  void removeCallHandlerListen(String methodName) {
    _handleMap.remove(methodName);
  }

  final MethodChannel _channel =
      MethodChannel('plugins.flutter.io/method/esRead/global');

  Channel.internal() {
    _channel.setMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == "nativePushHeaderToFlutter") {
        var response = Map<String, dynamic>.from(methodCall.arguments);
        var data = response["data"];
        if (data is Map) {
          data = Map<String, dynamic>.from(data);
        }
        AppData.setEnv(data);
      } else {
        PrintNative.printLog(
            "setMethodCallHandler" + methodCall.arguments.toString());
        if (_handleMap[methodCall.method] != null) {
          var response = Map<String, dynamic>.from(methodCall.arguments);
          var data = response["data"];
          if (data is Map) {
            data = Map<String, dynamic>.from(data);
          }
          return _handleMap[methodCall.method](data);
        } else {
          PrintNative.printLog("微信支付通知=======收到了3");
          throw MissingPluginException();
        }
      }
    });
  }

  getEnv() {
    return Future(() async {
      var response = await call<Map<String, dynamic>, Null>("getEnv");
      if (response.status) {
        return response.data;
      } else {
        return Map<String, dynamic>.from({});
      }
    });
  }

  /**
   * 打印日志
   */
  Future<ChannelResponse<Map<dynamic, dynamic>>> printNative(String log) {
    Map<String, dynamic> data = new Map();
    data["log"] = log;
    return call<Map<dynamic, dynamic>, Map<String, dynamic>>("print", data);
  }

  /**
   * 关闭当前native页面
   */
  Future<ChannelResponse<Map<dynamic, dynamic>>> backNative() {
    Map<String, dynamic> data = new Map();
    return call<Map<dynamic, dynamic>, Map<String, dynamic>>("back", data);
  }

  /*
   * 调用原生路由json跳转
   * data 一个跳转的map {"data":"跳转的json"}
   */
  Future<ChannelResponse<Map<dynamic, dynamic>>> goToPage(
      Map<String, dynamic> data) {
    return call<Map<dynamic, dynamic>, Map<String, dynamic>>("goToPage", data);
  }

  /*
   * 调用原生发送通知（广播）
   * data 一个跳转的map {"name":"通知名称","data":"通知的参数Map"}
   */
  Future<ChannelResponse<Map<dynamic, dynamic>>> pushNotification(
      Map<String, dynamic> data) {
    return call<Map<dynamic, dynamic>, Map<String, dynamic>>(
        "pushNotification", data);
  }

  /*
   * 保存缓存数据到native
   * data 缓存结构：map {"key":"缓存唯一标示 由flutter控制", "data":"缓存的String"}
   * result 结构：map{"result":"1"}
   */
  Future<ChannelResponse<Map<dynamic, dynamic>>> saveCache(
      String key, String data) {
    Map<String, dynamic> map = new Map();
    map["key"] = key;
    map["data"] = data;
    return call<Map<dynamic, dynamic>, Map<String, dynamic>>("saveCache", map);
  }

  /**
   * 删除缓存数据到native
   */
  Future<ChannelResponse<Map<dynamic, dynamic>>> removeCache(String key) {
    Map<String, dynamic> map = new Map();
    map["key"] = key;
    return call<Map<dynamic, dynamic>, Map<String, dynamic>>(
        "removeCache", map);
  }

  /*
   * 获取缓存数据在native
   * data 数据结构：map {"key":"缓存唯一标示 由flutter控制",}
   * result 结构：map{"data":"缓存数据"}
   */
  Future<String> getCache(String key) async {
    Map<String, dynamic> map = new Map();
    map["key"] = key;
    ChannelResponse<Map<dynamic, dynamic>> resultData =
        await call<Map<dynamic, dynamic>, Map<String, dynamic>>(
            "getCache", map);
    if (resultData.data != null) {
      Map<String, String> response = Map<String, String>.from(resultData.data);
      return response["data"];
    }
    return null;
  }



  /**
   * 提示
   */
  Future<ChannelResponse<Map<dynamic, dynamic>>> toast(String toastText) {
    Map<String, dynamic> data = new Map();
    data["toastText"] = toastText;
    return call<Map<dynamic, dynamic>, Map<String, dynamic>>("toast", data);
  }

  /**
   * 发送一个方法消息
   */
  Future<ChannelResponse<T>> call<T, P>(String method, [P params]) async {
    return Future(() async {
      try {
        var channelRequest = new ChannelMethodGlobal<P>(params);

        print('on 发送: ${channelRequest.toString()}');

        var response = (await _channel.invokeMethod<Map<dynamic, dynamic>>(
                method, channelRequest.toJson())) ??
            {};
        var data = response["data"];
        if (data is Map) {
          data = Map<String, dynamic>.from(data);
        }
        return ChannelResponse<T>(
            status: response["status"] ?? false,
            data: data ?? new Map(),
            errorCode: response["errorCode"] ?? -1);
      } on Exception {
        return ChannelResponse(status: false, data: null, errorCode: -1);
      }
    });
  }
}
