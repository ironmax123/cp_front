import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// APIサービスを提供するクラス
class Prediction {
  /// 年、性別、職業を指定して所得予測値を取得
  final String api = dotenv.env['API_KEY']!;
  Future<String> getPrediction(
      int year, String gender, String occupation) async {
    final response = await http.get(
      Uri.parse(
          '${api}predict?year=$year&gender=$gender&occupation=$occupation'),
    );
    try {
      if (response.statusCode == 200) {
        // 成功時は予測値を返す
        return (json.decode(response.body)["prediction"] as double)
            .toStringAsFixed(2);
      } else {
        // エラー時はエラーメッセージを返す
        return "予測エラー: ${json.decode(response.body)["error"]}";
      }
    } catch (e) {
      return "リクエストエラー: ${e.toString()}";
    }
  }
}
