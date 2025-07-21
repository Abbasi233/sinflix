import 'dart:developer';

enum ApiStatus {
  LOADING,
  COMPLETED,
  ERROR,
}

class ResponseInfo {
  final int code;
  final String message;

  ResponseInfo({
    required this.code,
    required this.message,
  });

  factory ResponseInfo.fromJson(Map<String, dynamic> json) {
    return ResponseInfo(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
}

class BaseResponse<T> {
  ResponseInfo? response;
  T? data;
  ApiStatus apiStatus = ApiStatus.COMPLETED;

  static String get successCode => "200";

  BaseResponse({
    this.response,
    this.data,
  });

  BaseResponse.loading() : apiStatus = ApiStatus.LOADING;

  BaseResponse.completed([this.data]) : apiStatus = ApiStatus.COMPLETED;

  BaseResponse.error(String message) : apiStatus = ApiStatus.ERROR;

  factory BaseResponse.fromJson(Map<String, dynamic>? json, T? Function(dynamic) dataFromJson) {
    if (json == null) return BaseResponse();

    try {
      final responseJson = json['response'] as Map<String, dynamic>?;
      final dataJson = json['data'];

      final response = responseJson != null ? ResponseInfo.fromJson(responseJson) : null;

      T? dataValue;
      if (response?.code == 200 && dataJson != null) {
        try {
          dataValue = dataFromJson(dataJson);
        } catch (e, stackTrace) {
          log(e.toString(), stackTrace: stackTrace);
          dataValue = null;
        }
      }

      return BaseResponse(
        response: response,
        data: dataValue,
      );
    } catch (e) {
      return BaseResponse(
        response: ResponseInfo(code: 0, message: e.toString()),
      );
    }
  }

  void when({
    void Function()? loading,
    void Function(dynamic data)? completed,
    void Function(String? message)? error,
  }) {
    switch (apiStatus) {
      case ApiStatus.LOADING:
        loading?.call();
        break;
      case ApiStatus.COMPLETED:
        completed?.call(data);
        break;
      case ApiStatus.ERROR:
        error?.call(response?.message);
        break;
    }
  }

  @override
  String toString() {
    return "Response: ${response?.code}, Message: ${response?.message}, Data: $data";
  }
}
