/**
 * 数据格式转换
 */
abstract class Json {
  void fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toMap();
}
