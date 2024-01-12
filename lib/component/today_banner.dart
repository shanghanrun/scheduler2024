import 'package:scheduler2024/const/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDate;
  final int count; // 일정 갯수
  const TodayBanner(
      {required this.selectedDate, required this.count, super.key});

  @override
  Widget build(BuildContext context) {
    const textStyle =
    TextStyle(fontWeight: FontWeight.bold, color: Colors.white);
    return Container(
      color: PRIMARY,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                '${selectedDate.year}년 ${selectedDate.month}월 ${selectedDate.day}일',
                style: textStyle),
            Text('$count개', style: textStyle),
          ],
        ),
      ),
    );
  }
}
