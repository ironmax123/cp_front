import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:model_prediction/pages/components/dropdown.dart';
import 'package:model_prediction/pages/components/year_slider.dart';

import '../domain/prediction.dart';

// ignore: camel_case_types
class incomePredictionPage extends HookWidget {
  const incomePredictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prediction = useState<String>("");
    final year = useState<int>(2023);
    final gender = useState<String>('全体');
    final occupation = useState<String>('正規雇用者の平均');

    Future<void> fetchPrediction() async {
      final result = await Prediction().getPrediction(
        year.value,
        gender.value,
        occupation.value,
      );
      prediction.value = result;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('予測モデル'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '予測結果:約${prediction.value.isEmpty ? '00' : prediction.value}万円',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 32),
            ),
            yearSlider(
              initialYear: year.value,
              onChanged: (int value) {
                year.value = value;
              },
            ),
            const SizedBox(height: 20),
            CustomDropdown(
              labelText: '性別',
              value: gender.value,
              items: const ['全体', '男性', '女性'],
              onChanged: (newValue) {
                gender.value = newValue!;
              },
            ),
            const SizedBox(height: 20),
            CustomDropdown(
              labelText: '職業',
              value: occupation.value,
              items: const [
                '正規雇用者の平均',
                '非正規雇用者の平均',
                '個人所得の平均',
              ],
              onChanged: (newValue) {
                occupation.value = newValue!;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchPrediction,
              child: const Text('予測'),
            ),
          ],
        ),
      ),
    );
  }
}
