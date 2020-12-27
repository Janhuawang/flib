import 'package:flutter/widgets.dart';

/**
 * 尺寸工具类
 */
class SizeTool {
  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getTop(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getBottom(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }
}
