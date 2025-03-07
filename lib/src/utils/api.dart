part of ghf;

final dio = Dio(BaseOptions(baseUrl: ""));
// dio.options.baseUrl = "asd";
// dio.interceptors.add(
//   InterceptorsWrapper(
//     onRequest: (options, handler) {
//     options.headers["Content-Type"] = "application/json";
//     return handler.next(options);
//     },
//     onResponse: (response, handler) {
//       return handler.next(response);
//     },
//     onError: (DioError e, handler) {
//       return handler.next(e);
//     }
//   )
// );