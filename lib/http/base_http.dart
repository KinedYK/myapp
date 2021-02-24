

import 'package:dio/dio.dart';
import 'package:myapp/http/interceptor.dart';

class Http {
  Dio dio;
  Response response;
  BaseOptions options;

  /// 选择环境
  String get baseUrl {
    final isProd = const bool.fromEnvironment('dart.vm.product');
    return isProd ? 'XXX-prod' : 'XXX-test';
  }

  Http() {
    /// [默认配置]
    options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );
    /// 初始化
    dio = new Dio(options);
    /// 设置[拦截器]
    dio.interceptors.add(CustomInterceptors());   
  }
  
  Future<dynamic> get(String uri, {dynamic params, Function errorCb}) async {
    try {
      Response response = await dio.get(uri, queryParameters: params);
      return response.data['data'];
    } on DioError catch (e) {
      if (errorCb != null) errorCb(e);
    }
  }

  Future<dynamic> post(String uri, {dynamic data, Function errorCb}) async {
    try {
      Response response = await dio.post(uri, data: data);
      return response.data['data'];
    } on DioError catch (e) {
      if (errorCb != null) errorCb(e);
    }
  }
}