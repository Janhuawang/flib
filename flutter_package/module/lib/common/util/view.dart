import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:module/common/image/image_util.dart';

class ViewTools {
  /**
   * 增加间隔
   */
  static Iterable<Widget> divideItem(List<Widget> items, double height) {
    if (items != null && !items.isEmpty) {
      List<Widget> list = new List();
      for (int i = 0; i < items.length; i++) {
        list.add(items[i]);
        if (i < items.length - 1) {
          list.add(new SizedBox(height: height));
        }
      }
      return list;
    }
    return items;
  }

  /**
   * 一个不展示的View
   */
  static Widget getNoneView() {
    return new Container(height: 0, width: 0);
  }

  /**
   * 加载缓冲圈
   */
  static Widget getProgressView() {
    return Center(child: CircularProgressIndicator());
  }

  /**
   * 加载失败
   */
  static Widget getFailView() {
    return Center(child: Text("数据有问题，请重新加载"));
  }

  /**
   * 数据为空页
   */
  static Widget getEmptyView() {
    return Center(child: Text("暂无数据"));
  }

  /**
   * 获取一个圆形widget
   */
  static Widget getAvatarWidget(String avatarUrl, double size,
      {double borderSize, Color borderColor}) {
    if (size == null || size == 0) {
      size = 50;
    }
    if (borderSize == null) {
      borderSize = 0;
    }
    if (borderColor == null) {
      borderColor = Colors.white;
    }

    return Container(
      width: size + borderSize,
      height: size + borderSize,
      decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: borderSize),
          borderRadius: BorderRadius.circular((size + borderSize) / 2)),
      child: ClipOval(
        child: getImageWidget(avatarUrl, size),
      ),
    );
  }

  /**
   * 获取一个Image widget
   */
  static Widget getImageWidget(String avatarUrl, double size) {
    return SizedBox(width: size,height: size,child: ImageTools.toImageStandard(avatarUrl),);
    // if (avatarUrl != null) {
    //   return ImageTools.toImageStandard(avatarUrl) Image.network(
    //     avatarUrl,
    //     height: size ?? 50.0,
    //     width: size ?? 50.0,
    //     fit: BoxFit.cover,
    //   );
    // } else {
    //   return Image.asset(
    //     "assets/images/image_pk_opponent_loading.png",
    //     height: size ?? 50.0,
    //     width: size ?? 50.0,
    //     fit: BoxFit.cover,
    //   );
    // }
  }

  /**
   * 获取一个带圆角的Button
   */
  static Widget getFlatButton(Widget widget, Color backgroundColor,
      {Color highlightColor = Colors.transparent,
      Brightness colorBrightness = Brightness.light,
      BorderRadius borderRadius,
      VoidCallback onPressed}) {
    return FlatButton(
      color: backgroundColor,
      highlightColor: highlightColor,
      colorBrightness: colorBrightness,
      child: widget,
      shape: borderRadius == null
          ? null
          : RoundedRectangleBorder(borderRadius: borderRadius),
      onPressed: onPressed,
    );
  }
}
