import 'package:flutter/material.dart';

const minYear = 1990;
const maxYear = 2050;
Widget yearSlider({
  required int initialYear,
  required ValueChanged<int> onChanged,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('選択した年: $initialYear'), // 選択された年を表示
      Slider(
        value: initialYear.toDouble(),
        min: minYear.toDouble(),
        max: maxYear.toDouble(),
        divisions: maxYear - minYear, // 年ごとに分割
        label: '$initialYear',
        onChanged: (double value) {
          onChanged(value.toInt()); // 年を更新
        },
      ),
    ],
  );
}
