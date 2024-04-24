import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';



class DioHelper {
  static late Dio dio;
  static init() {
    dio = Dio(
        BaseOptions(
          baseUrl: 'https://flutter.prominaagency.com/api/',
          receiveDataWhenStatusError: true,
          // receiveTimeout: Duration(seconds: 5),
        ));
  }

  static Future<Response> getdata(
      {required String Url,
        Map<String ,dynamic >? query,
        String? token,
        }) async {
    dio.options.headers = {
      'Authorization': token,
    };

    return await dio.get(Url, queryParameters: query);
  }

  static Future<Response> postdata({
    required String path,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String? token,


  }) async {
    dio.options.headers = {
      'Authorization': token,
    };

    return dio.post(
      path,
      queryParameters: query,
      data: data,
    );
  }




  static Future<Response> postFile({ required String path,String? token,data}) async
  {
    dio.options.headers = {
      'Authorization': token,
    };
    return dio.post(path , data: data , onReceiveProgress: (count, total) {
      print('$count , $total') ;
    },);





  }


}
