import 'package:flutter/material.dart';
import 'package:flutter_app/api/HttpApi.dart';
import 'package:flutter_app/main/home/ListItemBuilde.dart';
import 'package:flutter_app/model/HomeModelEntity.dart';
import 'package:flutter_app/utils/DioUtil.dart';
import 'package:flutter_refresh/flutter_refresh.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin  {

  int _itemCount = 0;

  List<HomeModelDataEntity> banner;
  List<HomeModelDataEntity> data;

  @override
  void initState() {
    // TODO: implement initState
    print("初始化");
    super.initState();
    data = new List();
    banner = new List();
    _loadData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  void _loadData() {
    DioUtil.getInstance().get(HttpApi.TODAY_URL, (results) {
      print(results);
      banner.clear();
      data.clear();
      HomeModelEntity result = HomeModelEntity.fromJson(results);
      result.category.forEach((name) {
        for (int i = 0; i < result.results[name].length; i++) {
          if (name == "福利") {
            banner.add(HomeModelDataEntity.fromJson(result.results[name][i]));
          } else {
            data.add(HomeModelDataEntity.fromJson(result.results[name][i]));
          }
        }
      });
      setState(() {
        this.banner = banner;
        this.data = data;
        this._itemCount =( banner.length !=0 ? 1:0 )+ data.length;
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Refresh(
      onHeaderRefresh: onHeaderRefresh,
      childBuilder: (BuildContext context,{ScrollController controller, ScrollPhysics physics}) {
        return new Container(
            child: new ListView.builder(
              physics: physics,
              controller: controller,
              itemBuilder: _itemBuilder,
              itemCount: _itemCount,
            ));
      },
    );
  }


  Future<Null> onHeaderRefresh() {
    //  throw new Exception("");
    return new Future.delayed(new Duration(seconds: 2), () {
      _loadData();
    });
  }

  Widget _itemBuilder(BuildContext context, int index) {
     if(index == 0 ){
       return HeadWedget(context,banner);
     }
     return ItemWedget(context, data[index-1]);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
