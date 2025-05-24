import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:latest_news/core/constants/constants.dart';

import '../model/status_model.dart';

class ApiClient {
  var logger = Logger(
    filter: null,
    printer: PrettyPrinter(),
    output: null,
  );
  final baseUrl = Constants.baseUrl;
  final username = Constants.username;
  final password = Constants.password;

  Dio dio = Dio();
  Future<StatusModel> postMethod({required String pathUrl,required Map<String, dynamic> body, dynamic header, required isHeader})async {
    try {
      final res = await dio.post("$baseUrl$pathUrl",
        options: Options(headers: {"Content_type" : "application/json"},),
        data: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      logger.d([
        'POST',
        "$baseUrl$pathUrl",
        body,
        res.statusCode,
        res.statusMessage,
        res.data,
      ]);
      if(res.statusCode! >= 200 && res.statusCode! < 300){
        return StatusModel(response: res.data, isSuccess: true, code: res.statusCode);
      }
      return StatusModel(response: res.data, isSuccess: false, code: res.statusCode);
    } on DioException catch(e ) {
      log(
        "postMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }


  Future<StatusModel> getMethod({required pathUrl, Map<String, dynamic>? header,Map<String, dynamic>?  body, required isHeader, bool anotherLink = false})async {
    String basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    try {
      final res = await dio
          .get("${anotherLink ? "" : baseUrl}$pathUrl",
        options: Options(headers: {"Content_type" : "application/json", "authorization":basicAuth}),
        data: jsonEncode(body ?? {}),
      ).timeout(const Duration(seconds: 60));
      logger.d([
        'GET',
        "$baseUrl$pathUrl",
        body,
        res.statusCode,
        res.statusMessage,
        // res.data,
      ]);
      if(res.statusCode! >= 200 && res.statusCode! < 300){
        return StatusModel(response: res.data, isSuccess: true, code: res.statusCode);
      }
      return StatusModel(response: res.data, isSuccess: false, code: res.statusCode);
    } on DioException catch(e) {
      logger.e([
        'GET',
        "$baseUrl$pathUrl",
        body,
        e.response?.statusCode,
        e.response?.statusMessage,
        e.response?.data,
      ]);
      return dioError(e);
    }
  }

  Future<StatusModel> putMethod({required pathUrl,required dynamic body, dynamic header, required isHeader})async {
    try {
      final res = await dio.put("$baseUrl$pathUrl",
        options: Options(headers:{"Content_type": "application/json"}),
        data: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      log(
          "putMethod pathUrl: $baseUrl$pathUrl"
              "\n\n"
              "body: $body"
              "\n\n"
              "code: ${res.statusCode}"
              "\n\n"
      );
      log("response: ${res.data}");
      if (res.statusCode == 200) {
        return StatusModel(response: res.data, isSuccess: true, code: 200);
      }
      return StatusModel(response: res.data,
          isSuccess: false,
          code: res.statusCode);
    } on DioException catch (e) {
      log(
        "putMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }

  Future<StatusModel> patchMethod({required String pathUrl,required Map<String, dynamic> body, dynamic header, required isHeader})async {
    try {
      final res = await dio.patch("$baseUrl$pathUrl",
        options: Options(headers:{"Content_type" : "application/json"},),
        data: jsonEncode(body),
      ).timeout(const Duration(seconds: 30));
      log(
          "patchMethod pathUrl: $baseUrl$pathUrl"
              "\n\n"
              "body: $body"
              "\n\n"
              "code: ${res.statusCode}"
              "\n\n"
      );
      log("response: ${res.data}");
      if(res.statusCode! >= 200 && res.statusCode! < 300){
        return StatusModel(response: res.data, isSuccess: true, code: res.statusCode);
      }
      return StatusModel(response: res.data, isSuccess: false, code: res.statusCode);
    } on DioException catch(e ) {
      log(
        "postMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }

  Future<StatusModel> deleteMethod({required String pathUrl, dynamic header, required isHeader, Map<String, dynamic>? body})async {
    try {
      final res = await dio.delete("$baseUrl$pathUrl",
          options: Options(headers:{"Content_type" : "application/json"}),
          data: jsonEncode(body ?? {})
      ).timeout(const Duration(seconds: 30));
      log(
          "deleteMethod pathUrl: $baseUrl$pathUrl"
              "\n\n"
              "body: $body"
              "\n\n"
              "code: ${res.statusCode}"
              "\n\n"
      );
      log("response: ${res.data}");
      if(res.statusCode == 200){
        return StatusModel(response: res.data, isSuccess: true, code: 200);
      }
      return StatusModel(response: ("unknownError"), isSuccess: false, code: res.statusCode);
    } on DioException catch(e) {
      log(
        "deleteMethod pathUrl: $baseUrl$pathUrl"
            "\n\n"
            "body: $body"
            "\n\n"
            "code: ${e.response?.statusCode}"
            "\n\n"
            "response: ${e.response?.data}",
      );
      return dioError(e);
    }
  }
}

StatusModel dioError(DioException e){
  if(e.type == DioExceptionType.connectionTimeout){
    return StatusModel(response: jsonEncode({"detail" : ("connection_error")}), isSuccess: false, code: e.response?.statusCode);
  }
  if(e.type == DioExceptionType.connectionError){
    return StatusModel(response: jsonEncode({"detail" : ("connection_error")}), isSuccess: false, code: e.response?.statusCode);
  }
  try{
    if(e.response!.statusCode! >= 500){
      return StatusModel(response: jsonEncode({"detail" : ("server_error")}), isSuccess: false, code: e.response?.statusCode);
    }
  }catch(e){}
  return StatusModel(response: e.response, isSuccess: false, code: e.response?.statusCode);
}