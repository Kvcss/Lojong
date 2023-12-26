import 'package:flutter/material.dart';

class ArticleWidget extends StatelessWidget {
  final String title;
  final String text;
  final String imageUrl;

  const ArticleWidget({super.key, 
    required this.title,
    required this.text,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: Color.fromRGBO(139, 143, 153, 1),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Color.fromRGBO(134, 138, 148, 1),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
              
              },
              icon: const Icon(Icons.share, color: Color.fromRGBO(81, 83, 87, 2)),
              label: const Text(
                'Compartilhar',
                style: TextStyle(
                  color: Color.fromRGBO(81, 83, 87, 2),
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Color.fromRGBO(236, 236, 236, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8), 
          const Divider(
            color: Colors.grey, 
            thickness: 0.5, 
          ),
        ],
      ),
    );
  }
}
