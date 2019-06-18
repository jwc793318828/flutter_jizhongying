import 'package:flutter/material.dart';
import 'package:flutter_app/api/HttpApi.dart';
import 'package:flutter_app/main/classify/ClassifyItemPage.dart';
import 'package:flutter_app/utils/DioUtil.dart';


class ClassifyPage extends StatefulWidget {

  @override
  _ClassifyPageState createState()  =>_ClassifyPageState();

}

class _ClassifyPageState extends State<ClassifyPage>  with AutomaticKeepAliveClientMixin,SingleTickerProviderStateMixin {

   var _controller;
  var _tabs = <ClassifyItemPage>[  ClassifyItemPage(type: "all", ),
                      ClassifyItemPage(type: "Android", ),
                      ClassifyItemPage(type: "iOS", ),
                      ClassifyItemPage(type: "休息视频", ),
                       ClassifyItemPage(type: "福利", ),
                      ClassifyItemPage(type: "拓展资源", ),
                     ClassifyItemPage(type: "前端", ),
                      ClassifyItemPage(type: "瞎推荐" ),
                       ClassifyItemPage(type: "App", )
  ];
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TabController(length: _tabs.length,vsync: this); //动画效果的异步处理，默认格式，背下来即可
   }
  
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
  
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.blue,title: TabBar(
        tabs: _tabs.map(( page){
          return new Tab(text: page.type);
        }).toList(),
        controller:_controller,//配置控制器

        isScrollable: true,
        indicatorColor: Color(0xffffffff),
        labelColor: Colors.white,
        labelStyle: TextStyle(
          fontSize: 13.0,
         ),
        unselectedLabelColor: Colors.black87,
        unselectedLabelStyle: TextStyle(
          fontSize: 13.0,
        ),),),
      body: TabBarView(
          controller: _controller, //配置控制器
          children: _tabs
              .map(( item) =>item )
              .toList()),
    );
  }
  
  
  
  


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
