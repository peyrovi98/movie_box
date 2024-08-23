import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_box/res/texts.dart';
import 'package:movie_box/src/data/source/server/service_response_model.dart';

class WebService {
  static WebService? _singleton;

  factory WebService(Dio dio) {
    _singleton ??= WebService._internal(dio);
    return _singleton!;
  }

  late Dio _dio;

  WebService._internal(Dio dio) {
    _dio = dio;
  }

  Future<ServiceResponseModel> callApi(MethodType type, String callUrl,
      {Map<String, dynamic>? body,
      File? img,
      String? imgKey,
      bool getFromCache = false}) async {
    try {
      // _dio.options.headers.remove(HttpHeaders.authorizationHeader);
      // _dio.options.headers.putIfAbsent("token", () => token);
      _dio.options.headers
          .putIfAbsent(HttpHeaders.contentTypeHeader, () => "application/json");

      Response response =
          Response(requestOptions: RequestOptions(), statusCode: 408, data: {});

      FormData formData = FormData.fromMap({});
      if (img != null) {
        MultipartFile item = await MultipartFile.fromFile(img.path);
        body?.putIfAbsent(imgKey!, () => item);
        formData = FormData.fromMap(body!);
      }

      switch (type) {
        case MethodType.GET:
          response = await _dio.get(callUrl);
          break;
        case MethodType.POST:
          if (img != null) {
            response = await _dio.post(callUrl, data: formData);
          } else {
            response = await _dio.post(callUrl, data: json.encode(body));
          }
          break;
        case MethodType.PATCH:
          response = await _dio.patch(callUrl, data: json.encode(body));
          break;
        case MethodType.DELETE:
          response = await _dio.delete(callUrl);
          break;
        case MethodType.PUT:
          response = await _dio.put(callUrl);
          break;
      }

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        if (response.data == null || response.data.toString().isEmpty) {
          return ServiceResponseModel(true, "", "");
        }
        return ServiceResponseModel(
            true, response.statusMessage ?? "", response.data);
      } else {
        if (response.statusCode == 401) {
          await GetIt.instance.get();
          return ServiceResponseModel(false, Texts.tokenInvalid, "",
              statusCode: response.statusCode);
        } else if (response.statusCode == 408) {
          return ServiceResponseModel(false, Texts.noConnection, "",
              statusCode: response.statusCode);
        } else if (response.statusCode == 417) {
          return ServiceResponseModel(false, Texts.noConnection, "",
              statusCode: response.statusCode);
        } else if (response.statusCode == 426) {
          return ServiceResponseModel(false, Texts.oldVersion, response.data);
        } else {
          return ServiceResponseModel(false, response.statusMessage ?? "", "",
              statusCode: response.statusCode);
        }
      }
    } on Exception catch (ex) {
      int statusCode = 400;
      try {
        if (ex is DioError || ex is DioException) {
          statusCode = ex.response?.statusCode ?? 400;
          return ServiceResponseModel(false, ex.response?.statusMessage ?? "", "",
              statusCode: statusCode);
        }
      } catch (ex) {
        statusCode = 400;
      }
      if (kReleaseMode) {
        return ServiceResponseModel(false, Texts.noConnection, "",
            statusCode: statusCode);
      } else if (ex is DioException) {
        statusCode = ex.response?.statusCode ?? 400;
        return ServiceResponseModel(false, ex.message ?? "", "",
            statusCode: statusCode);
      } else {
        return ServiceResponseModel(
            false, 'ex: $ex' /*Texts.no_connection*/, "",
            statusCode: statusCode);
      }
    }
  }
}

enum MethodType { GET, POST, PATCH, DELETE, PUT }
