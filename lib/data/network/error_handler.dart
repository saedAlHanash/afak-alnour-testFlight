import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'failure.dart';

enum DataSource {
  success,
  noContent,
  badRequest,
  forbidden,
  unAuthorised,
  notFound,
  internalServerError,
  connectTimeOut,
  cancel,
  receiveTimeOut,
  sendTimeOut,
  cacheError,
  noInternetConnection,
  unProcessableEntity,
  unknown
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(
            code: ResponseCode.success, message: ResponseMessage.successApi);
      case DataSource.noContent:
        return Failure(
            code: ResponseCode.noContent, message: ResponseMessage.noContent);
      case DataSource.badRequest:
        return Failure(
            code: ResponseCode.badRequest, message: ResponseMessage.badRequest);
      case DataSource.forbidden:
        return Failure(
            code: ResponseCode.forbidden, message: ResponseMessage.forbidden);
      case DataSource.unAuthorised:
        return Failure(
            code: ResponseCode.unauthorized,
            message: ResponseMessage.unauthorized);
      case DataSource.notFound:
        return Failure(
            code: ResponseCode.notFound, message: ResponseMessage.notFound);
      case DataSource.internalServerError:
        return Failure(
            code: ResponseCode.internalServerError,
            message: ResponseMessage.internalServerError);
      case DataSource.connectTimeOut:
        return Failure(
            code: ResponseCode.connectTimeOut,
            message: ResponseMessage.connectTimeOut);
      case DataSource.cancel:
        return Failure(
            code: ResponseCode.cancel, message: ResponseMessage.cancelApi);
      case DataSource.receiveTimeOut:
        return Failure(
            code: ResponseCode.receiveTimeout,
            message: ResponseMessage.receiveTimeout);
      case DataSource.sendTimeOut:
        return Failure(
            code: ResponseCode.sendTimeOut,
            message: ResponseMessage.sendTimeOut);
      case DataSource.cacheError:
        return Failure(
            code: ResponseCode.cacheError, message: ResponseMessage.cacheError);
      case DataSource.noInternetConnection:
        return Failure(
            code: ResponseCode.noInternetConnecting,
            message: ResponseMessage.noInternetConnecting);
      case DataSource.unknown:
        return Failure(
            code: ResponseCode.unknown, message: ResponseMessage.unknown);
      case DataSource.unProcessableEntity:
        return Failure(
            code: ResponseCode.unprocessableEntity,
            message: ResponseMessage.unProcessableEntity);
    }
  }
}

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      failure = _handleError(error);
    } else {
      failure = DataSource.unknown.getFailure();
    }
  }
}

Failure _handleError(DioError error) {

  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeOut.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeOut.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.receiveTimeOut.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response!.statusCode != null &&
          error.response!.statusMessage != null) {
        if (error.response!.statusCode == 422) {
            return Failure(
                code: error.response!.statusCode ?? 0,
                message: error.response!.data['message']);

        } else if (error.response!.statusCode! < 422 &&
            error.response!.statusCode! >= 400) {
          return Failure(
              code: error.response!.statusCode!,
              message: error.response!.data['message']);
        } else {
          return Failure(
              code: error.response!.statusCode ?? 0,
              message: error.response!.statusMessage ?? "");
        }
      } else {
        return DataSource.unknown.getFailure();
      }
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.badCertificate:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      return DataSource.unknown.getFailure();
  }
}

class ResponseCode {
  static const int success = 200;
  static const int noContent = 201;
  static const int badRequest = 400;
  static const int forbidden = 403;
  static const int unauthorized = 401;
  static const int notFound = 404;
  static const int unprocessableEntity = 404;
  static const int internalServerError = 500;

  // local status code
  static const int connectTimeOut = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeOut = -4;
  static const int cacheError = -5;
  static const int noInternetConnecting = -6;
  static const int unknown = -7;
}

class ResponseMessage {
  static  String successApi = 'successApi'.tr;
  static  String noContent = 'noContent'.tr;
  static  String badRequest = 'badRequest'.tr;
  static  String forbidden = 'forbidden'.tr;
  static  String unauthorized = 'unauthorized'.tr;
  static  String notFound = 'notFound'.tr;
  static  String unProcessableEntity = 'unProcessableEntity'.tr;
  static  String internalServerError =
      'internalServerError'.tr;

  // local status code
  static  String connectTimeOut = 'connectTimeOut'.tr;
  static  String cancelApi = 'cancelApi'.tr;
  static  String receiveTimeout = 'receiveTimeout'.tr;
  static  String sendTimeOut = 'sendTimeOut'.tr;
  static  String cacheError = 'cacheError'.tr;
  static  String noInternetConnecting =
      'noInternetConnecting'.tr;
  static  String unknown = 'unknown'.tr;
}

class ApiInternalStatus {
  static const int success = 1;
  static const int failure = 0;
}
