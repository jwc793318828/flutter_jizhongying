import 'dart:convert';

import 'package:dio/dio.dart';
import 'dart:io';

import 'package:flutter_app/utils/ToastUtil.dart';

class DioUtil {
  static final String GET = "get";
  static final String POST = "post";
  static final String DATA = "data";
  static final String CODE = "errorCode";

  final bool isProxyChecked = true;
  final String proxy = "192.168.0.114:8888";
  final String BASE_URL = "";
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
      baseUrl: BASE_URL,
      headers: {'platform': 'android' },
      // ignore: argument_type_not_assignable
      connectTimeout: 5000,
      receiveTimeout: 100000,
    ));
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return isProxyChecked && Platform.isAndroid;
      };
      client.findProxy = (url) {
        return isProxyChecked ? 'PROXY $proxy' : 'DIRECT';
      };
    };
  }

  //get请求
  get(String url, Function successCallBack,
      {data, Function errorCallBack}) async {
    _requestHttp(url, successCallBack, GET, data, errorCallBack);
  }

  //post请求
  post(String url, Function successCallBack,
      {params, Function errorCallBack}) async {
    _requestHttp(url, successCallBack, POST, params, errorCallBack);
  }

  _requestHttp(String url, Function successCallBack,
      [String method, FormData params, Function errorCallBack]) async {
    String errorMsg = '';
    int code;
    try {
      Response response;
      _addStartHttpInterceptor(); //添加请求之前的拦截器
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

  String getToken() { // 获取 token  可以联网请求
    return "1111";
  }

  void _addStartHttpInterceptor() {
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
    }, onRequest: (opt) {
      Map<String, String> map = {
        "version4": "11",
        "token1": "dddddddddd"
      }; // 可以传递的公共参数
      opt.headers.addAll(map);

      return opt;
    }));
  }
}
