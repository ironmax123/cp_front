import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'components/dropdown.dart';
import 'components/year_slider.dart';

import '../domain/prediction.dart';

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final prediction = useState<String>("");
    final year = useState<int>(2023);
    final gender = useState<String>('全体');
    final occupation = useState<String>('正規雇用者の平均');

    /// ローディングダイアログを表示する関数
    void showLoadingDialog(BuildContext context) {
      showDialog(
        context: context,
        barrierDismissible: false, // 外側タップで閉じない
        builder: (context) {
          return const AlertDialog(
            content: SizedBox(
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('データを取得中...'),
                ],
              ),
            ),
          );
        },
      );
    }

    Future<void> fetchPrediction() async {
      // クルクル表示
      showLoadingDialog(context);

      try {
        final result = await Prediction().getPrediction(
          year.value,
          gender.value,
          occupation.value,
        );
        prediction.value = result;
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(); // クルクルを閉じる
      } catch (e) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('データ取得に失敗しました')),
        );
      }
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
            const SizedBox(width: double.infinity),
            SizedBox(
              width: 512,
              child: yearSlider(
                initialYear: year.value,
                onChanged: (int value) {
                  year.value = value;
                },
              ),
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
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.black87,
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: const BorderSide(),
                minimumSize: const Size(256, 64),
              ),
              onPressed: () async {
                await fetchPrediction();
                // ignore: use_build_context_synchronously
                await context.push(
                  '/analysis',
                  extra: prediction.value,
                );
              },
              child: const Text('実行',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
