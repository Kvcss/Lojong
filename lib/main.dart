import 'package:flutter/material.dart';
import 'package:lojong_app/src/view/insights.dart';
import 'package:lojong_app/src/viewmodel/insights_viewmodel.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InsightsViewModel())
      ],
      child: MaterialApp(
        title: 'Lojong',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Insights(),
      ),
    );
  }
}
