import 'package:flutter/material.dart';
import 'package:lojong_app/helpers/network.dart';
import 'package:lojong_app/src/model/article_model.dart';
import 'package:lojong_app/src/model/articles_model.dart';
import 'package:lojong_app/src/model/quotes_model.dart';
import 'package:lojong_app/src/model/videos_model.dart';

class InsightsViewModel extends ChangeNotifier {
  final ApiProvider apiProvider = ApiProvider();
  List<Article> articles = [];
  List<ListItem> listItems = [];
  List<Quote> quotes = [];
  List<Video> videos = [];

  bool isLoading = false;

  InsightsViewModel() {
    loadArticles();
    loadVideos();
    loadQuotes();
  }

  Future<void> loadArticles() async {
    try {
      isLoading = true;
      notifyListeners();

      bool isInternetAvailable = await apiProvider.isInternetAvailable();

      if (isInternetAvailable) {
        final response = await apiProvider.getArticleList();
        if (response['list'] != null) {
          articles.addAll((response['list'] as List)
              .map((item) => Article.fromJson(item))
              .toList());
          for (var article in articles) {
            await apiProvider.downloadAndCacheImage(article.imageUrl!);
          }
        }
      } else {
         final List<Article> cachedArticles = await apiProvider.getCachedArticles();
        articles.addAll(cachedArticles);
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('Error loading articles: $e');
    }
  }

  Future<void> loadListItems() async {
    try {
      isLoading = true;
      notifyListeners();

      bool isInternetAvailable = await apiProvider.isInternetAvailable();

      if (isInternetAvailable) {
        final response = await apiProvider.getArticleList();
        if (response['list'] != null) {
          listItems.addAll((response['list'] as List)
              .map((item) => ListItem.fromJson(item))
              .toList());
        }
      } else {
        final List<ListItem> cachedListItems = await apiProvider.getCachedListItems();
        listItems.addAll(cachedListItems);
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('Error loading list items: $e');
    }
  }

  Future<void> loadQuotes() async {
    try {
      isLoading = true;
      notifyListeners();

      bool isInternetAvailable = await apiProvider.isInternetAvailable();

      if (isInternetAvailable) {
        final response = await apiProvider.getQuoteList();
        if (response['list'] != null) {
          quotes.addAll((response['list'] as List)
              .map((item) => Quote.fromJson(item))
              .toList());
        }
      } else {
        final List<Quote> cachedQuotes = await apiProvider.getCachedQuotes();
        quotes.addAll(cachedQuotes);
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('Error loading quotes: $e');
    }
  }

  Future<void> loadVideos() async {
    try {
      isLoading = true;
      notifyListeners();

      bool isInternetAvailable = await apiProvider.isInternetAvailable();

      if (isInternetAvailable) {
        final response = await apiProvider.getVideoList();
        if (response.statusCode == 200) {
          final List<dynamic> responseData = response.data;
          if (responseData is List) {
            final List<Video> videoList = responseData
                .map((item) => Video.fromJson(item))
                .toList();

          
            for (var video in videoList) {
              await apiProvider.downloadAndCacheImage(video.imageUrl!);
            }

            videos.addAll(videoList);
          }
        }
      } else {
        final List<Video> cachedVideos = await apiProvider.getCachedVideos();
        videos.addAll(cachedVideos);
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print('Error loading videos: $e');
    }
  }
}
