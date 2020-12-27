import 'package:flutter/material.dart';

import 'common/util/view.dart';

const url =
    'http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var tabTitle = [
    '页面1',
    '页面2',
    '页面3',
  ];

  ScrollController _scrollController = ScrollController();

  bool isShowState = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      // print('滚动到位置${_scrollController.position.extentAfter}');

      if (!isShowState && _scrollController.position.extentAfter <= 56.0) {
        setState(() {
          isShowState = true;
        });
        print('隐藏');
      } else if (isShowState && _scrollController.position.extentAfter > 56.0) {
        setState(() {
          isShowState = false;
        });
        print('展示');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabTitle.length,
        child: Scaffold(
            body: Container(
          child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Container(
                height: 164,
                color: Colors.red,
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    NestedScrollView(
                      controller: _scrollController,
                      headerSliverBuilder: (context, bool) {
                        return [
                          // SliverAppBar(
                          //   expandedHeight: 238,
                          //   floating: true,
                          //   snap: false,
                          //   pinned: true,
                          //   flexibleSpace: FlexibleSpaceBar(
                          //       centerTitle: true,
                          //       background: Container(
                          //         color: ColorsUtil.toColor("FEE51A"),
                          //         child: Flex(
                          //           direction: Axis.vertical,
                          //           children: <Widget>[],
                          //         ),
                          //       )),
                          //   bottom: TabBar(
                          //     unselectedLabelColor: Colors.black38,
                          //     indicatorColor: Colors.green,
                          //     indicatorSize: TabBarIndicatorSize.label,
                          //     indicatorWeight: 5.0,
                          //     tabs: tabTitle.map((e) {
                          //       return Tab(
                          //           child: Container(
                          //             color: Colors.blue,
                          //           ));
                          //     }).toList(),
                          //   ),
                          // ),

                          new SliverPersistentHeader(
                              pinned: false,
                              delegate: SliverDelegateHeader(
                                200,
                                Container(
                                    color: Colors.blue,
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      color: Colors.white,
                                      height: 56,
                                      child: TabBar(
                                        unselectedLabelColor: Colors.black38,
                                        indicatorColor: Colors.green,
                                        indicatorSize:
                                            TabBarIndicatorSize.label,
                                        indicatorWeight: 1,
                                        tabs: tabTitle.map((e) {
                                          return Tab(
                                              child: Container(
                                            color: Colors.black,
                                          ));
                                        }).toList(),
                                      ),
                                    )),
                              ))

                          // SliverPersistentHeader(
                          //     delegate: new SliverTabBarDelegate(
                          //   TabBar(
                          //     unselectedLabelColor: Colors.black38,
                          //     indicatorColor: Colors.green,
                          //     indicatorSize: TabBarIndicatorSize.label,
                          //     indicatorWeight: 5.0,
                          //     tabs: tabTitle.map((e) {
                          //       return Tab(
                          //           child: Container(
                          //         color: Colors.blue,
                          //       ));
                          //     }).toList(),
                          //   ),
                          //   color: Colors.white,
                          // )),

                          // new SliverPersistentHeader(
                          //   delegate: SliverDelegateHeader(50, Container(color: Colors.black,)),
                          //   pinned: true,
                          //   floating: true,
                          // ),
                        ];
                      },
                      body: TabBarView(
                        children: tabTitle
                            .map((s) => ListView.builder(
                                  itemBuilder: (context, int) =>
                                      Center(child: Text("123")),
                                  itemCount: 150,
                                ))
                            .toList(),
                      ),
                    ),
                    Container(
                        child: !isShowState
                            ? ViewTools.getNoneView()
                            : Container(
                                color: Colors.white,
                                child: TabBar(
                                  unselectedLabelColor: Colors.black38,
                                  indicatorColor: Colors.green,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  indicatorWeight: 1,
                                  tabs: tabTitle.map((e) {
                                    return Tab(
                                        child: Container(
                                      color: Colors.black,
                                    ));
                                  }).toList(),
                                ),
                              ))
                  ],
                ),
              )
            ],
          ),
        )));
  }
}

class SliverDelegateHeader extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final Color color;
  final double height;

  const SliverDelegateHeader(this.height, this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
    );
  }

  @override
  bool shouldRebuild(SliverDelegateHeader oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => this.height;

  @override
  double get minExtent => this.height;
}

class TabWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.red,
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 100);
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}

class TestPageMain extends StatelessWidget {
  TestPageMain();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primaryColor: Colors.blue), // 更改主题
      home: TestPage(),
    );
  }
}

class TestPage2 extends StatefulWidget {
  @override
  _TestPage2State createState() => _TestPage2State();
}

class _TestPage2State extends State<TestPage2> {
  var tabTitle = [
    '页面1',
    '页面2',
    '页面3',
  ];

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: tabTitle.length,
        child: Scaffold(
          body: new CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                expandedHeight: 302.0,
                floating: true,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      "我是可以跟着滑动的title",
                    ),
                    background: Image.network(
                      url,
                      fit: BoxFit.cover,
                    )),
              ),
              new SliverToBoxAdapter(
                child: new TabBar(
                  tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                  indicatorColor: Colors.red,
                  unselectedLabelColor: Colors.black,
                  labelColor: Colors.red,
                ),
              ),
              new SliverFillRemaining(
                child: TabBarView(
                  children: tabTitle
                      .map((s) => ListView.builder(
                            itemBuilder: (context, int) => Text("123"),
                            itemCount: 150,
                          ))
                      .toList(),
                ),
                // child: ListView.builder(
                //   itemBuilder: (context, int) => Text("123"),
                //   itemCount: 150,
                // ),
              )
            ],
          ),
        ));
  }
}
