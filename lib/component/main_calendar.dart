import 'package:scheduler2024/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class MainCalendar extends StatelessWidget {
  final OnDaySelected onDaySelected;
  final DateTime selectedDate;

  const MainCalendar(
      {required this.onDaySelected, required this.selectedDate, super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_kr', // 'ko_kr'
      onDaySelected: onDaySelected,
      selectedDayPredicate: (date) {
        return (date.year == selectedDate.year &&
            date.month == selectedDate.month &&
            date.day == selectedDate.day);
      },
      firstDay: DateTime(1800, 1, 1),
      lastDay: DateTime(3000, 1, 1),
      focusedDay: DateTime.now(),
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
        titleTextStyle: TextStyle(
            fontSize: 16, color: Colors.blue, fontWeight: FontWeight.bold),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: LIGHT_GREY,
        ),
        weekendDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: LIGHT_GREY,
        ),
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: PRIMARY, width: 2),
        ),
        defaultTextStyle:
        TextStyle(color: DARK_GREY, fontWeight: FontWeight.w600),
        weekendTextStyle:
        TextStyle(color: DARK_GREY, fontWeight: FontWeight.w600),
        selectedTextStyle:
        const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      ),
    );
  }
}
