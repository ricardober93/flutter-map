import 'package:dio/dio.dart';

const accessToken =
    'pk.eyJ1IjoicmljYXJkb2JlcjkzIiwiYSI6ImNscDdkY3FmODBpOWkya3Fpa25pd2dsMmgifQ.x1Em6CbITy0N9XmNPdrK7w';

class TrafficInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }
}
