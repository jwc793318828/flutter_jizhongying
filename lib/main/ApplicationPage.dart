import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main/pages/ClassifyPage.dart';
import 'package:flutter_app/main/pages/HomePage.dart';
import 'package:flutter_app/main/pages/UserPage.dart';

class ApplicationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  int page = 0;
  String title = "首页";
  PageController pageController;

  List<String> _titles = <String>["首页", "分类", "我的"];


  //定义底部导航项目
  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text("首页"),
    ),
    new BottomNavigationBarItem(
      icon: Icon(Icons.tune),
      title: Text("分类"),
    ),
    new BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text("我的"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: this.page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[HomePage(), ClassifyPage(), UserPage()],
        controller: pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CupertinoTabBar(
        items: _bottomTabs,
        currentIndex: page,
        activeColor: Colors.blue,
        onTap: onBarTap,
      ),
    );
  }

  void onBarTap(int index) {
    pageController.jumpToPage(index);
   /* pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.ease);*/ // 这个切换会有动画效果。但是不是相邻切换会显示中间的页面
  }

  void onPageChanged(int index) {
    setState(() {
      this.page = index;
      title = _titles[index];
    });
  }
}
