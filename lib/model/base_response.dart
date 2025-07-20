import 'dart:developer';

enum ApiStatus {
  LOADING,
  COMPLETED,
  ERROR,
}

class BaseResponse<T> {
  int? pageNumber;
  int? totalPageSize;
  int? resultSize;
  int? totalRecordSize;
  int? timestamp;
  String? path;
  int? status;
  String? error;
  String? code;
  String? description;
  T? body;
  ApiStatus apiStatus = ApiStatus.COMPLETED;

  static String get successCode => "1";

  BaseResponse({
    this.code,
    this.description,
    this.body,
    this.pageNumber,
    this.totalPageSize,
    this.resultSize,
    this.totalRecordSize,
  });

  BaseResponse.loading() : apiStatus = ApiStatus.LOADING;

  BaseResponse.completed([this.body]) : apiStatus = ApiStatus.COMPLETED;

  BaseResponse.error(this.description) : apiStatus = ApiStatus.ERROR;

  factory BaseResponse.fromJson(Map<String, dynamic>? json, T? Function(dynamic) body) {
    if (json == null) return BaseResponse();

    try {
      T? bodyValue;
      final rawBody = json['body'];

      if (rawBody == null) {
        bodyValue = null;
      } else if (rawBody is String && T.toString() != 'String' && T.toString() != 'String?') {
        bodyValue = null;
      } else {
        try {
          bodyValue = body(rawBody);
        } catch (e, stackTrace) {
          log(e.toString(), stackTrace: stackTrace);
          bodyValue = null;
          rethrow;
        }
      }

      return BaseResponse(
        code: json['code'] ?? json['status']?.toString(),
        description: json['description'] ?? json['error'],
        body: bodyValue,
        pageNumber: json['pageNumber'],
        totalPageSize: json['totalPageSize'],
        resultSize: json['resultSize'],
        totalRecordSize: json['totalRecordSize'],
      );
    } catch (e) {
      return BaseResponse(
        code: json['code'] ?? json['status']?.toString(),
        description: json['description'] ?? json['error'] ?? e.toString(),
      );
    }
  }

  void when({
    void Function()? loading,
    void Function(dynamic data)? completed,
    void Function(String? description)? error,
  }) {
    switch (apiStatus) {
      case ApiStatus.LOADING:
        loading?.call();
        break;
      case ApiStatus.COMPLETED:
        completed?.call(body);
        break;
      case ApiStatus.ERROR:
        error?.call(description);
        break;
    }
  }

  @override
  String toString() {
    return "Code: $code, Description: $description, Body: $body";
  }
}
