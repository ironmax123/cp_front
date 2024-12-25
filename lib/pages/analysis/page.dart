import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});
  final res = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('予測結果')),
        body: Column(
          children: [
            const Text('結果は'),
            Text(res),
            ElevatedButton(onPressed: () {}, child: const Text("分析に戻る"))
          ],
        ));
  }
}
