

import 'package:module/common/service/app_data.dart';

/**
 * 通信api
 */
enum Method { GET, POST }

class RequestApi {
  String url;
  Method method;

  RequestApi(this.url, this.method);
}

/**
 * Api 定义类
 */
class HttpApi {
  static String getBaseUrl() {
    return AppData.isDebug
        ? "http://dev.esread.com"
        : "https://api.v1.esread.com";
  }

  static final userInfo = RequestApi(
    HttpApi.getBaseUrl() + '/uc/v1/user/info',
    Method.GET,
  );

  static final pkShareQRImage = RequestApi(
    HttpApi.getBaseUrl() +
        "/uc/v1/wechat/user/student/official/qrcode/generate",
    Method.GET,
  );

  static final getPKData = RequestApi(
    HttpApi.getBaseUrl() + '/rc/v8/activity/pk/page/context',
    Method.GET,
  );

  static final submitPKData = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v8/activity/pk/result/submit",
    Method.POST,
  );

  static final getSprintData = RequestApi(
    // 考试冲刺开始
    HttpApi.getBaseUrl() + "/rc/v10/activity/withTest/question/start",
    Method.GET,
  );

  static final submitSprintData = RequestApi(
    // 考试冲刺提交
    HttpApi.getBaseUrl() + "/rc/v10/activity/withTest/question/submit",
    Method.POST,
  );

  static final examSprintShare = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v8/activity/bilingual/page/student/share",
    Method.GET,
  );

  static final examSprintResultAd = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/activity/withTest/recommend/ad",
    Method.GET,
  );

  /**
   * 商品id 获取微信支付的参数
   * 参数：payMemberId
   */
  static final buyWeChatVIP = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v1/pay/wechat/app/unified/order",
    Method.POST,
  );

  /**
   * 商品id 微信扫码支付参数 换取二维码
   * 参数：payMemberId
   */
  static final buyQRVIP = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v1/pay/wechat/qrcode/unified/order",
    Method.POST,
  );

  /**
   * 查询订单状态
   * 参数：payMemberId
   */
  static final queryOrder = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v1/pay/order/status",
    Method.GET,
  );

  /**
   * 获取精品列表数据
   */
  static final getBoutiqueBookList = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/vip/zone/selectBoutiqueBookList",
    Method.GET,
  );

  /**
   * 获取精品详情数据
   */
  static final getBoutiqueBookDetail = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/vip/zone/selectBoutiqueBookDetail",
    Method.GET,
  );

  /**
   * 获取精品绘本列表
   */
  static final getBoutiqueBookListById = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/vip/zone/selectBoutiqueBookListById",
    Method.GET,
  );

  /**
   * 购买会员多支付的费用信息
   */
  static final getExtraPayMember = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/vip/zone/selectExtraPayMember",
    Method.GET,
  );

  /*
   * VIP专区，VIP信息
   */
  static final selectUserVipDetail = RequestApi(
    HttpApi.getBaseUrl() + "/uc/v1/user/vip/info/base",
    Method.GET,
  );

  /*
   * VIP专区，VIP活动
   */
  static final selectVipValidReadActivity = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/vip/zone/selectVipValidReadActivity",
    Method.GET,
  );

  /*
   * VIP专区，系列图书
   */
  static final selectSeriesBooks = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/vip/zone/selectSeriesBooks",
    Method.GET,
  );

  /*
   * VIP专区，新书优先读
   */
  static final selectNewBook = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/vip/zone/selectNewBook",
    Method.GET,
  );

  /*
   * VIP专区，新书优先读列表
   */
  static final selectNewBookList = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/vip/zone/selectNewBookList",
    Method.GET,
  );

  /*
   * 绘本分类，筛选绘本
   */
  static final bookFileter = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v10/book/search/list",
    Method.GET,
  );

  /**
   * 查询vip数据
   */
  static final vipStatust = RequestApi(
    HttpApi.getBaseUrl() + "rc/v1/pay/order/statust",
    Method.GET,
  );

  /**
   * 获取分享相关参数
   */
  static final getShareInfo = RequestApi(
    HttpApi.getBaseUrl() + "/rc/v1/basic/share/info/json",
    Method.GET,
  );


}
