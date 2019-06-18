import 'package:flutter/material.dart';


class UserPage extends StatefulWidget{

  @override
  _UserPageState createState()  =>_UserPageState();

}

class _UserPageState extends State<UserPage>  with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      body:  Center(
        child: Text("第3个页面"),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
