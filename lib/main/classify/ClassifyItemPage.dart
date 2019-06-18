import 'package:flutter/material.dart';
import 'package:flutter_app/api/HttpApi.dart';
import 'package:flutter_app/main/classify/ListItemBuilde.dart';
import 'package:flutter_app/model/ClassifyModel.dart';
import 'package:flutter_app/utils/DioUtil.dart';
import 'package:flutter_refresh/flutter_refresh.dart';
class ClassifyItemPage extends StatefulWidget{
  String type ;
  ClassifyItemPage({Key key , this.type} ) :super(key:key) ;

  @override
  _ClassifyItemPageState createState()  => _ClassifyItemPageState();

}

class _ClassifyItemPageState extends State<ClassifyItemPage> with AutomaticKeepAliveClientMixin {

  int _index = 1 ;
  ClassifyModel classifyModel;
   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Refresh(
      onHeaderRefresh: onHeaderRefresh,
      onFooterRefresh: onFooterRefresh,
      childBuilder: (BuildContext context,{ScrollController controller, ScrollPhysics physics}) {
         return new Container(

            child: new ListView.builder(
              physics: physics,
              controller: controller,
              itemBuilder: _itemBuilder,

              itemCount: classifyModel == null ? 0 : classifyModel.results.length,
            ));
      },
    );
  }

  void _loadData(){
    DioUtil.getInstance().get(widget.type =='福利'? (HttpApi.FEED_URL+widget.type +"/10/"+_index.toString()) : (HttpApi.SEARCH_URL+widget.type +"/count/10/page/"+_index.toString()), (result){
      ClassifyModel bean = ClassifyModel.fromJson(result);
      if(_index == 1 ){
        this.classifyModel = bean ;
        setState(() { });
      }else{
          classifyModel.results.addAll(bean.results);
          setState(() {   });
      }

    },data: null, errorCallBack: (error){
    });
  }

  Future<Null> onHeaderRefresh() async{
      return new Future.delayed(new Duration(seconds: 2), () {
       _index =1 ;
       _loadData();
     });
  }

  // 底部刷新
  Future<Null> onFooterRefresh() async {
    return new Future.delayed(new Duration(seconds: 2), () {
      _index++ ;
      _loadData();
    });
  }
  Widget _itemBuilder( BuildContext context,int index ){
     if(widget.type == '福利'){
       return ItemImageWedget(context, classifyModel.results[index]);
     }
     return  ItemWedget(context,this.classifyModel.results[index]);

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
