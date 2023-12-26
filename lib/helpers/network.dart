import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lojong_app/src/model/article_model.dart';
import 'package:lojong_app/src/model/articles_model.dart';
import 'package:lojong_app/src/model/quotes_model.dart';
import 'package:lojong_app/src/model/videos_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ApiProvider {
  final String _baseURL = "https://applojong.com/api";
  final String _userToken = "O7Kw5E2embxod5YtL1h1YsGNN7FFN8wIxPYMg6J9zFjE6Th9oDssEsFLVhxf";

  late Dio _dio;
  late CacheManager _cacheManager;

  ApiProvider() {
    _dio = Dio();
    _dio.options.headers["Authorization"] = "Bearer $_userToken";

    _cacheManager = CacheManager(
      Config(
        'api_cache',
        stalePeriod: const Duration(days: 7),
        maxNrOfCacheObjects: 100,
      ),
    );
  }
  Future<bool> isInternetAvailable() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
  }
  Future<void> downloadAndCacheImage(String url) async {
    await _cacheManager.downloadFile(url);
  }

  CachedNetworkImage getCachedNetworkImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }

  Future<Map<String, dynamic>> get(String endpoint, Map<String, dynamic> params) async {
  try {
    Response<dynamic> response = await _dio.get("$_baseURL/$endpoint", queryParameters: params);
    return response.data;
  } catch (e) {
    throw Exception("Failed to load data: $e");
  }
}
 Future<Response<dynamic>> getVideos(String endpoint, Map<String, dynamic> params) async {
    try {
      Response<dynamic> response = await _dio.get("$_baseURL/$endpoint", queryParameters: params);
      return response;
    } catch (e) {
      throw Exception("Failed to load data: $e");
    }
  }

  Future<File> getFile(String url) async {
    File file = await _cacheManager.getSingleFile(url);
    return file;
  }

  Future<Map<String, dynamic>> getArticleList() async {
 
  final Map<String, dynamic> params = {};
  return await get('articles2', params);
}


  Future<Map<String, dynamic>> getArticleContent(int articleId) async {
    final params = {'articleid': articleId};
    return await get('article-content', params);
  }

  Future<Map<String, dynamic>> getQuoteList() async {
    final Map<String, dynamic> params = {};
    return await get('quotes2', params);
  }

 Future<Response> getVideoList() async {
 
  final Map<String, dynamic> params = {};
  return await getVideos('videos', params);
  
}
  
 Future<List<Article>> getCachedArticles() async {
  final cacheDir = await getTemporaryDirectory();
  final file = File('${cacheDir.path}/cached_articles.json');

  if (file.existsSync()) {
    final jsonData = await file.readAsString();
    final List<dynamic> jsonList = json.decode(jsonData);
    final List<Article> cachedArticles = jsonList
        .map((item) => Article.fromJson(item))
        .toList();
    return cachedArticles;
  } else {
    return [];
  }
}

Future<List<ListItem>> getCachedListItems() async {
  final cacheDir = await getTemporaryDirectory();
  final file = File('${cacheDir.path}/cached_list_items.json');

  if (file.existsSync()) {
    final jsonData = await file.readAsString();
    final List<dynamic> jsonList = json.decode(jsonData);
    final List<ListItem> cachedListItems = jsonList
        .map((item) => ListItem.fromJson(item))
        .toList();
    return cachedListItems;
  } else {
    return [];
  }
}

Future<List<Quote>> getCachedQuotes() async {
  final cacheDir = await getTemporaryDirectory();
  final file = File('${cacheDir.path}/cached_quotes.json');

  if (file.existsSync()) {
    final jsonData = await file.readAsString();
    final List<dynamic> jsonList = json.decode(jsonData);
    final List<Quote> cachedQuotes = jsonList
        .map((item) => Quote.fromJson(item))
        .toList();
    return cachedQuotes;
  } else {
    return [];
  }
}

Future<List<Video>> getCachedVideos() async {
  final cacheDir = await getTemporaryDirectory();
  final file = File('${cacheDir.path}/cached_videos.json');

  if (file.existsSync()) {
    final jsonData = await file.readAsString();
    final List<dynamic> jsonList = json.decode(jsonData);
    final List<Video> cachedVideos = jsonList
        .map((item) => Video.fromJson(item))
        .toList();
    return cachedVideos;
  } else {
    return [];
  }
}

Future<void> saveListToFile(String fileName, List<dynamic> dataList) async {
  final cacheDir = await getTemporaryDirectory();
  final file = File('${cacheDir.path}/$fileName');
  await file.writeAsString(json.encode(dataList));
}

}
