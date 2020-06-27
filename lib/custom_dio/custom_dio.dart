import 'package:dio/dio.dart';
import 'requestInterceptor.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio addInterceptors(Dio dio) {
  return dio
    ..interceptors.add(
      InterceptorsWrapper(
//        onRequest: (RequestOptions options) => requestInterceptor(options),
        onResponse: (Response response) => responseInterceptor(response),
//        onError: (DioError dioError) => errorInterceptor(dioError),
      ),
    );
}

responseInterceptor(Response response) {
  dynamic responseInterceptor(Response options) async {
    if (options.headers.value("verifyToken") != null) {
      //if the header is present, then compare it with the Shared Prefs key
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var verifyToken = prefs.get("VerifyToken");

      // if the value is the same as the header, continue with the request
      if (options.headers.value("verifyToken") == verifyToken) {
        return options;
      }
    }

  }
}

