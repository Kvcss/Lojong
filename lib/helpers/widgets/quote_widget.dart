import 'package:flutter/material.dart';
import 'package:lojong_app/src/model/quotes_model.dart';

class QuotesPage extends StatelessWidget {
  final List<Quote> quotes;

  QuotesPage({required this.quotes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: quotes.length,
        itemBuilder: (context, index) {
          int cardIndex = index % 3;
          return QuoteCard(
            quote: quotes[index],
            cardIndex: cardIndex,
          );
        },
        separatorBuilder: (BuildContext context, int index) => SizedBox(height: 3), // Adicionar espaçamento entre os cards
      ),
    );
  }
}

class QuoteCard extends StatelessWidget {
  final Quote quote;
  final int cardIndex;

  QuoteCard({required this.quote, required this.cardIndex});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6),
      child: Card(
        color: Colors.transparent, 
        child: Container(
          height: 380.0, // Definir altura fixa
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0), // Ajustar o raio dos cantos
            gradient: _getBackgroundColor(cardIndex),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  quote.text!,
                  style: TextStyle(
                    color: _getTextColor(cardIndex),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 8, 
                ),
                SizedBox(height: 10),
                Text(
                  quote.author!,
                  style: TextStyle(
                    color: _getTextColor(cardIndex),
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40), 
                ElevatedButton.icon(
                  onPressed: () {
                    
                  },
                  icon: const Icon(Icons.share, color: Colors.white), 
                  label: const Text(
                    'Compartilhar',
                    style: TextStyle(color: Colors.white), 
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: _getButtonColor(cardIndex),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(int cardIndex) {
    if (cardIndex == 0) {
      return Color.fromRGBO(64, 103, 171, 1); // Cor para o primeiro card
    } else if (cardIndex == 1) {
      return Color.fromRGBO(208, 168, 134, 1); // Cor para o segundo card
    } else {
      return Color.fromRGBO(191, 122, 138, 1); // Cor para o terceiro card
    }
  }

  LinearGradient _getBackgroundColor(int cardIndex) {
    // Determinar a decoração gradiente com base no índice do card
    if (cardIndex == 0) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(149, 196, 232, 1),
          Color.fromRGBO(242, 247, 250, 1),
        ],
      );
    } else if (cardIndex == 1) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(232, 213, 162, 1),
          Color.fromRGBO(238, 192, 154, 1),
        ],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color.fromRGBO(232, 151, 126, 1),
          Color.fromRGBO(217, 139, 159, 1),
        ],
      );
    }
  }

  Color _getTextColor(int cardIndex) {
    // Determinar a cor do texto com base no índice do card
    if (cardIndex == 0) {
      return Color.fromRGBO(68, 109, 175, 1); // Cor para o primeiro card
    } else if (cardIndex == 1) {
      return Color.fromRGBO(107, 94, 72, 1); // Cor para o segundo card
    } else {
      return Colors.white; // Cor para o terceiro card
    }
  }
}

  