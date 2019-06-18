package com.flutter.flutter_app;

import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    D d1 = new D(398.99);
    D d2 = new D(399);
    System.out.println(d1.num == d2.num);
  }


  class D{
    private  double num ;

    public D(double num) {
      this.num = num;
    }
  }
}


