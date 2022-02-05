import 'package:cams/model/feed_response.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final String apiKey =
      "563492ad6f917000010000012d405feabe444630949ed877c15ff0e4";
  static String baseUrl = "https://api.pexels.com";
  final Dio _dio = Dio();
  var getFeedsAPI = '$baseUrl/videos/search';

  Future<FeedResponse> getFeeds() async {
    var params = {
      "api_key": apiKey,
      "query": "nba",
      "size": "medium",
      "orientation": "portrait"
    };

    try {
      _dio.interceptors
          .add(InterceptorsWrapper(onRequest: (options, handler) async {
        options.headers["Authorization"] = apiKey;
        _dio.interceptors.requestLock.unlock();
        return handler.next(options);
      }));
      Response response = await _dio.get(getFeedsAPI, queryParameters: params);
      return FeedResponse.fromJson(response.data);
    } catch (error) {
      return FeedResponse.withError("$error");
    }
  }
}
