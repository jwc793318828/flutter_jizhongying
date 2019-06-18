import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/main/web/web.dart';
import 'package:flutter_app/model/ClassifyModel.dart';
 import 'package:flutter_app/utils/TimeUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';


Widget ItemWedget(BuildContext context, ClassifyModelResult  bean) {
  return  new Card(
    elevation: 2.0,//阴影
    color: Colors.white,//背景色
     child: new GestureDetector(
       onTap: (){
         _itemListener(context,bean);
       } ,
       child:  new Padding(
         child: new Column(
           children: <Widget>[
             new Row(
               children: <Widget>[
                 new Icon(Icons.access_time,size: 12,color: Colors.blue,),
                 new Container(child: new Text(bean.publishedAt,style: TextStyle(color: Colors.grey,fontSize: 14) ),margin: EdgeInsets.only(left: 2),alignment: FractionalOffset.center,),
                 new Expanded(child:  new Align(
                   alignment: FractionalOffset.centerRight,
                   child:  new Text(getTimestampString(DateTime.parse(bean.publishedAt) ),style: TextStyle(color: Colors.grey,fontSize: 13) ),
                 )
                 ),
               ],
             ),
             new Container(
                 padding: EdgeInsets.only(left: 0,bottom: 10,top: 5,right: 5),
                 alignment:FractionalOffset.centerLeft,
                 child: new Text(bean.desc ,style: TextStyle(color: Colors.black,fontSize: 15, fontWeight: FontWeight.w400)
                 )),
             new Row(
               children: <Widget>[
                 new Text("作者:",style: TextStyle(color: Colors.grey,fontSize: 12)),
                 new Text(bean.who,style: TextStyle(color: Colors.blue,fontSize: 12)),
               ],
             )
           ],


         ),
         padding: EdgeInsets.all(10)
     ),),
    margin: EdgeInsets.only(left: 10,top: 1,bottom: 10,right: 10),
  );
}

void _itemListener( BuildContext context, ClassifyModelResult  bean){

  Navigator.push(context,new MaterialPageRoute(builder: (context) => new web(title: bean.desc,url: bean.url,)));
}


Widget ItemImageWedget(BuildContext context, ClassifyModelResult  bean) {
  return  new Card(
    elevation: 2.0,//阴影
    color: Colors.white,//背景色
    child: new Container(
      child:  /*new Image.network(
        bean.url,
        fit: BoxFit.cover,
      ),*/
      ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
              bean.url,
             fit: BoxFit.cover,
           )
      )
    ),
    margin: EdgeInsets.only(left: 10,top: 1,bottom: 10,right: 10),
  );
}