 import 'package:flutter/material.dart';
import 'package:lojong_app/helpers/widgets/article_widget.dart';
import 'package:lojong_app/helpers/widgets/quote_widget.dart';
import 'package:lojong_app/helpers/widgets/video_widget.dart';
import 'package:lojong_app/src/viewmodel/insights_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Insights extends StatefulWidget {
  const Insights({Key? key}) : super(key: key);

  @override
  _InsightsState createState() => _InsightsState();
}

class _InsightsState extends State<Insights> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  Widget _buildNavItem(int index, String title) {
    bool isSelected = _currentIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 30),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected
                ? const Color.fromRGBO(199, 128, 128, 1)
                : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final insightsController = Provider.of<InsightsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(224, 144, 144, 1),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
              },
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(199, 128, 128, 1),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 110),
            const Center(
              child: Text(
                'INSPIRAÇÕES',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15, 
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(199, 128, 128, 1),
                borderRadius: BorderRadius.circular(80),
              ),
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(0, 'VÍDEOS'),
                  _buildNavItem(1, 'ARTIGOS'),
                  _buildNavItem(2, 'CITAÇÕES'),
                ],
              ),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          Center(
            child: ListView.builder(
              itemCount: insightsController.videos.length,
              itemBuilder: (context, index) {
                final video = insightsController.videos[index];
                return VideoWidget(
                    name: video.name!,
                    description: video.description!,
                    videoUrl: video.url!, thumbnailUrl: video.imageUrl!);
              },
            ),
          ),
          Center(
            child: ListView.builder(
              itemCount: insightsController.articles.length,
              itemBuilder: (context, index) {
                final article = insightsController.articles[index];
                return ArticleWidget(
                  title: article.title!,
                  text: article.text!,
                  imageUrl: article.imageUrl!,
                );
              },
            ),
          ),
         QuotesPage(quotes: insightsController.quotes),
        ],
      ),
    );
  }
}