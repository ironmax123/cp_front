import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AnalysisPage extends HookWidget {
  final String? response;

  const AnalysisPage({super.key, this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('分析結果')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          const Text(
            '結果は',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '約${response ?? '00'}万円',
            style: const TextStyle(
              fontSize: 48,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),
    );
  }
}
