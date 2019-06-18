import 'dart:convert';

import 'package:dio/dio.dart';
 import 'dart:io';


import 'package:flutter_app/utils/ToastUtil.dart';

class DioUtil {
  static final String GET = "get";
  static final String POST = "post";
  static final String DATA = "data";
  static final String CODE = "errorCode";

  Dio dio;
  static DioUtil _instance;

  static DioUtil getInstance() {
    if (_instance == null) {
      _instance = DioUtil();
    }
    return _instance;
  }

  DioUtil() {
    dio = Dio(BaseOptions(
      /*baseUrl: "http://192.168.5.6:8085",*/
      headers: {'platform': 'android', 'version': 11.0},
      // ignore: argument_type_not_assignable
      connectTimeout: 5000,
      receiveTimeout: 100000,
    ));
    dio.interceptors.add(InterceptorsWrapper(onError: (error) {
      if (error.response != null && error.response.statusCode == 401) {
        //401代表token过期
        Dio dio = DioUtil().dio; //获取Dio单例
        dio.lock();
        String accessToken = getToken(); //异步获取新的accessToken
        dio.unlock();
        //重新发起一个请求获取数据
        var request = error.response.request;
        request.headers['token'] = accessToken;

        try {
          var response = dio.request(request.path,
              data: request.data,
              queryParameters: request.queryParameters,
              cancelToken: request.cancelToken,
              options: request,
              onReceiveProgress: request.onReceiveProgress);
          return response;
        } on DioError catch (e) {
          return e;
        }
      }
    }));
  }

  //get请求
  get(String url  ,Function successCallBack,
      {data, Function errorCallBack}) async {
    _requestHttp(url, successCallBack ,GET, data, errorCallBack);
  }

  //post请求
  post(String url,  Function successCallBack,
      {params, Function errorCallBack}) async {
    _requestHttp(url, successCallBack,  POST, params, errorCallBack);
  }

  _requestHttp(String url, Function successCallBack,
      [String method, FormData params, Function errorCallBack]) async {
    String errorMsg = '';
    int code;
    print("=====================请求开始==================");
    print(url);
    if (params != null && params.isNotEmpty) {
      print(params);
    }
    print("=====================请求结束==================");

    try {
      Response response;
      //_addStartHttpInterceptor(dio); //添加请求之前的拦截器
      if (method == GET) {
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
       } else if (method == POST) {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
       code = response.statusCode;
      if (code != 200) {
        errorMsg = '错误码：' + code.toString() + '，' + response.data.toString();
        _error(errorCallBack, errorMsg);
        return;
      }

     /* T  a =  ;
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      if (dataMap != null && dataMap[CODE] != 0) {
        errorMsg =
            '错误码：' + dataMap[CODE].toString() + '，' + response.data.toString();
        _error(errorCallBack, errorMsg);
        return;
      }*/
      String dataStr = json.encode(response.data);
      Map<String, dynamic> dataMap = json.decode(dataStr);
      if (successCallBack != null) {
        successCallBack(dataMap);
      }
    } catch (exception) {
      _error(errorCallBack, exception.toString());
    }
  }

  _error(Function errorCallBack, String error) {
    ToastUtil.showToast(error.toString());
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }

  String getToken() {

    return "1111";
  }
}
