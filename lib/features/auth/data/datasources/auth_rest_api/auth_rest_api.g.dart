// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_rest_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter

class _AuthRestApi implements AuthRestApi {
  _AuthRestApi(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= 'https://caseapi.servicelabs.tech/user/';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<HttpResponse<BaseResponse<LoginResponseModel?>?>> login(
    String email,
    String password,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    final _options =
        _setStreamType<HttpResponse<BaseResponse<LoginResponseModel?>?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/login',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late BaseResponse<LoginResponseModel?>? _value;
    try {
      _value = _result.data == null
          ? null
          : BaseResponse<LoginResponseModel?>.fromJson(
              _result.data!,
              (json) => json == null
                  ? null
                  : LoginResponseModel.fromJson(json as Map<String, dynamic>),
            );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<BaseResponse<RegisterResponseModel?>?>> register(
    String email,
    String password,
    String name,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email, 'password': password, 'name': name};
    final _options =
        _setStreamType<HttpResponse<BaseResponse<RegisterResponseModel?>?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/register',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late BaseResponse<RegisterResponseModel?>? _value;
    try {
      _value = _result.data == null
          ? null
          : BaseResponse<RegisterResponseModel?>.fromJson(
              _result.data!,
              (json) => json == null
                  ? null
                  : RegisterResponseModel.fromJson(
                      json as Map<String, dynamic>,
                    ),
            );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<BaseResponse<ProfileResponseModel?>?>> profile() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options =
        _setStreamType<HttpResponse<BaseResponse<ProfileResponseModel?>?>>(
          Options(method: 'GET', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/profile',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late BaseResponse<ProfileResponseModel?>? _value;
    try {
      _value = _result.data == null
          ? null
          : BaseResponse<ProfileResponseModel?>.fromJson(
              _result.data!,
              (json) => json == null
                  ? null
                  : ProfileResponseModel.fromJson(json as Map<String, dynamic>),
            );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  @override
  Future<HttpResponse<BaseResponse<UploadPhotoResponseModel?>?>> uploadPhoto(
    File photo,
  ) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = FormData();
    _data.files.add(
      MapEntry(
        'photo',
        MultipartFile.fromFileSync(
          photo.path,
          filename: photo.path.split(Platform.pathSeparator).last,
        ),
      ),
    );
    final _options =
        _setStreamType<HttpResponse<BaseResponse<UploadPhotoResponseModel?>?>>(
          Options(method: 'POST', headers: _headers, extra: _extra)
              .compose(
                _dio.options,
                '/upload_photo',
                queryParameters: queryParameters,
                data: _data,
              )
              .copyWith(
                baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl),
              ),
        );
    final _result = await _dio.fetch<Map<String, dynamic>?>(_options);
    late BaseResponse<UploadPhotoResponseModel?>? _value;
    try {
      _value = _result.data == null
          ? null
          : BaseResponse<UploadPhotoResponseModel?>.fromJson(
              _result.data!,
              (json) => json == null
                  ? null
                  : UploadPhotoResponseModel.fromJson(
                      json as Map<String, dynamic>,
                    ),
            );
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
