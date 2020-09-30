/*
 * 项目名:    snp
 * 包名       base.http
 * 文件名:    http_util
 * 创建时间:  2020/8/25 on 4:47 PM
 * 描述:     
 *
 * @author   Dino
 */
export 'package:snp/beans/result_data_bean.dart';

import 'dart:convert';
import 'dart:io';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:snp/apis.dart';
import 'package:snp/beans/result_data_bean.dart';
import 'package:snp/common/base/base_config.dart';
import 'package:snp/common/base/base_exception.dart';
import 'package:snp/common/common.dart';
import 'package:snp/common/utils/object_util.dart';
import 'package:snp/common/utils/user_util.dart';

//class ResultData {
//  var data;
//  bool hasNextPage;
//  int size;
//
//  ResultData({this.data, this.hasNextPage, this.size});
//}

//class ErrorData {
//  int errCode;
//  String errMsg;
//
//  ErrorData({this.errCode, this.errMsg});
//
//  String toString() {
//    return 'errCode=$errCode; errMsg=$errMsg';
//  }
//}

typedef SuccessCallBack = void Function(ResultData resultData);

typedef ErrorCallBack = void Function(ResultData errorData);

HttpUtil http = HttpUtil.getInstance();

class HttpUtil {
  static HttpUtil instance;
  Dio dio;
  BaseOptions options;

//  String _clientId = SpUtil.getString(Config.sp_key_client_id);

  static HttpUtil getInstance() {
    if (instance == null) {
      instance = HttpUtil._();
      instance._init();
    }
    return instance;
  }

  HttpUtil._();

  void _init() {
    options = BaseOptions(
      baseUrl: Config.baseUrl,
      connectTimeout: 15000,
      receiveTimeout: 5000,
    );

    //抓包
    DefaultHttpClientAdapter adapter = DefaultHttpClientAdapter();
//    adapter.onHttpClientCreate = (HttpClient client) {
//      client.findProxy = (uri) => 'PROXY 192.168.31.194:8888';
//    };
    dio = Dio(options)..httpClientAdapter = adapter;
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) {
          if (options.path == API.verifyUser || options.path != API.register) {
            if (options.method.toUpperCase() != 'GET' &&
                options.data != null &&
                options.data is Map) {
              List keys = (options.data as Map).keys.toList();
              keys.sort();
              String plant = '';
              for (int i = 0; i < keys.length; i++) {
                plant +=
                    '${i == 0 ? '' : '&'}${keys[i]}=${options.data[keys[i]]}';
              }

              // print('加密前参数:$plant');
              // print('加密私钥:${user.privateKey}');
              var key = utf8.encode(user.privateKey);
              var bytes = utf8.encode(plant);

              var hmac = Hmac(sha256, key);
              var digest = hmac.convert(bytes);
              options.data['signature'] = hex.encode(digest.bytes);
            }
            options.headers['uuid'] = user.clientId;
            options.headers['token'] = user.token;
            // options.headers['uuid'] = '123456';
            // options.headers['token'] = 'ob8fafdb8c3059b2a22a1504ef3ea6119050a8eb2b';
          }
        },
      ),
    );

    // 添加拦截器
    if (Config.isDebug) {
      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (RequestOptions options) {
            print("================== 请求数据 ==========================");
            print("url = ${options.uri.toString()}");
            print("headers = ${options.headers}");
            print("params = ${options.data}");
          },
          onResponse: (Response response) {
            print("================== 响应数据 ==========================");
            print("url = ${response.request.uri}");
            print("code = ${response.statusCode}");
            print("data = ${response.data}");
//            print("\n");
          },
          onError: (DioError e) {
            print("================== 错误响应数据 ======================");
            print("url = ${e.request.uri}");
            print("type = ${e.type}");
            print("message = ${e.message}");
            print("error = ${e.error.toString()}");
////            print("\n");
//            if (e.type == DioErrorType.RESPONSE &&
//                e.response.statusCode == 401
////              UserUtil.instance.doLogout(null);
////              Toast.show('登录信息失效,请重新登录');
//              dio.clear();
//            }
          },
        ),
      );
    }
  }

  Future<ResultData> get(
    url, {
    params,
    options,
    cancelToken,
    SuccessCallBack onSuccess,
    ErrorCallBack onError,
    isList = false,
    String path,
  }) async {
    Response response;
    try {
      response = await dio.get(
        url + (path ?? ''),
        queryParameters: params,
        cancelToken: cancelToken,
      );
      return _handleRequest(
        response.data,
        onSuccess: onSuccess,
        onError: onError,
      );
    } on DioError catch (e) {
      return _handleError(e, onError);
      rethrow;
    }
    return response?.data;
  }

  Future<ResultData> post(
    url, {
    params,
    options,
    cancelToken,
    SuccessCallBack onSuccess,
    ErrorCallBack onError,
    String path,
  }) async {
    Response response;
    try {
      response = await dio.post(
        url + (path ?? ''),
        data: params,
        cancelToken: cancelToken,
      );
      return _handleRequest(
        response.data,
        onSuccess: onSuccess,
        onError: onError,
      );
    } on DioError catch (e) {
      return _handleError(e, onError);
      rethrow;
    }
    return response?.data;
  }

  Future<ResultData> put(
    url, {
    params,
    options,
    cancelToken,
    SuccessCallBack onSuccess,
    ErrorCallBack onError,
    String path,
  }) async {
    Response response;
    try {
      response = await dio.put(
        path != null ? url + path : url,
        data: params,
        cancelToken: cancelToken,
      );
      return _handleRequest(
        response.data,
        onSuccess: onSuccess,
        onError: onError,
      );
    } on DioError catch (e) {
      return _handleError(e, onError);
      rethrow;
    }
    return response?.data;
  }

  Future<ResultData> delete(
    url, {
    params,
    options,
    cancelToken,
    SuccessCallBack onSuccess,
    ErrorCallBack onError,
    String path,
  }) async {
    Response response;
    try {
      response = await dio.delete(
        path != null ? url + path : url,
        data: params,
        cancelToken: cancelToken,
      );
      return _handleRequest(
        response.data,
        onSuccess: onSuccess,
        onError: onError,
      );
    } on DioError catch (e) {
      return _handleError(e, onError);
      rethrow;
    }
    return response?.data;
  }

  ResultData _handleError(DioError e, ErrorCallBack onError) {
    int code = 9999;
    String msg = e.message;
    if (e is DioError) {
      switch (e.type) {
        case DioErrorType.CONNECT_TIMEOUT:
          code = 1002;
          msg = '连接超时';
          break;
        case DioErrorType.SEND_TIMEOUT:
          code = 1003;
          msg = '发送超时';
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          code = 1004;
          msg = '接收超时';
          break;
        case DioErrorType.RESPONSE:
          code = e.response.statusCode;
          msg = 'HTTP响应错误';
          break;
        case DioErrorType.CANCEL:
          code = 1005;
          msg = '请求被取消';
          break;
        case DioErrorType.DEFAULT:
          code = 9999;
          msg = '网络开小差了~';
          print(e.message);
          break;
      }
    }
    ResultData error = ResultData.error(code, msg);
    if (onError != null) onError(error);
    return error;
  }

  /*
   * 请求成功处理
   */
  ResultData _handleRequest(data, {onSuccess, onError}) {
    try {
      ResultData result = ResultData.fromJson(data);
      if (result != null && result.code == 1) {
        if (onSuccess != null) onSuccess(result);
        return result;
      } else {
        var error = ResultData.error(
          result?.code ?? 1001,
          result?.msg ?? '数据格式错误,解析失败',
        );
        if (onError != null) onError(error);
        return error;
      }
    } catch (e) {
      var error = ResultData.error(
        1001,
        '数据格式错误,解析失败',
      );
      if (onError != null) onError(error);
      return error;
      rethrow;
    }
  }

//  /*
//    通用的请求
//  */
//  Future<dynamic> request({
//    String method = 'get',
//    @required String url,
//    String path,
//    params,
//    data,
//    options,
//    cancelToken,
//    @required SuccessCallBack onSuccess,
//    ErrorCallBack onError,
//  }) async {
//    Response response;
//    var _data = data;
//    try {
//      if (method.toLowerCase().trim() == 'get') {
//        response = await dio.get(
//          path != null ? url + path : url,
//          queryParameters: ifEmpty(params, null),
//          cancelToken: cancelToken,
//        );
//      } else {
//        response = await dio.post(
//          path != null ? url + path : url,
//          queryParameters: ifEmpty(params, null),
//          data: _data != null ? FormData.from(_data) : null,
//          cancelToken: cancelToken,
//        );
//      }
//
//      Map data = response.data;
//      bool isList = data.containsKey('hasNextPage');
//      if (data['success']) {
//        onSuccess(ResultData(
//            data: data['data'],
//            hasNextPage: isList ? data['hasNextPage'] : null,
//            size: isList ? data['size'] : null));
//      } else {
//        if (onError != null) {
//          var errorData = ErrorData(
//              errCode: isEmpty(data['errCode']) ? '' : data['errCode'],
//              errMsg: isEmpty(data['errMsg']) ? '' : data['errMsg']);
//          onError(errorData);
//        }
//      }
//    } on DioError catch (e) {
//      rethrow;
//    }
//    return response?.data;
//  }
//
//  /*
//  form表单提交
//   */
//  formPost(
//    url, {
//    SuccessCallBack onSuccess,
//    ErrorCallBack onError,
//    params,
//    options,
//    cancelToken,
//  }) async {
////    var formData = params != null ? FormData.from(params) : null;
//    Response response;
//    try {
//      response = await dio.post(
//        url,
//        data: params,
//        options: Options(
//          contentType: ContentType.parse("application/x-www-form-urlencoded"),
//        ),
//      );
//      _handleRequest(
//        response.data,
//        isLogin: url == Api.login,
//        onSuccess: onSuccess,
//        onError: onError,
//      );
//    } on DioError catch (e) {
//      if (onError != null) {
//        onError(ErrorData(
//            errMsg: e.response.data.toString(),
//            errCode: e.response.statusCode));
//      }
//      rethrow;
//    }
//    return response?.data;
//  }
}
