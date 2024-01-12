import 'package:scheduler2024/component/main_calendar.dart';
import 'package:scheduler2024/component/schedule_bottom_sheet.dart';
import 'package:scheduler2024/component/schedule_card.dart';
import 'package:scheduler2024/component/today_banner.dart';
import 'package:scheduler2024/const/colors.dart';
import 'package:scheduler2024/model/schedule_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  bool isNewSchedule = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: const Text('스케줄 관리')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: PRIMARY,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isDismissible: true,
            isScrollControlled: true,
            builder: (_) => ScheduleBottomSheet(
              selectedDate: selectedDate,
              isNewSchedule: isNewSchedule,
              id: '',
            ),
          );
        },
      ),
      body: Column(
        children: [
          MainCalendar(
            selectedDate: selectedDate,
            onDaySelected: (selectedDate, focusedDate) {
              print('selectedDate: $selectedDate');
              print('focusedDate: $focusedDate');
              onDaySelected(selectedDate, focusedDate);
            },
          ),
          const SizedBox(height: 8),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('schedule')
                  .where('date',
                  isEqualTo:
                  '${selectedDate.year}${selectedDate.month.toString().padLeft(2, "0")}${selectedDate.day.toString().padLeft(2, "0")}')
                  .snapshots(),
              builder: (context, snapshot) {
                return TodayBanner(
                  selectedDate: selectedDate,
                  count: snapshot.data?.docs.length ?? 0,
                );
              }),
          const SizedBox(height: 8),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('schedule')
                    .where('date',
                    isEqualTo:
                    '${selectedDate.year}${selectedDate.month.toString().padLeft(2, "0")}${selectedDate.day.toString().padLeft(2, "0")}')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('일정 정보를 가져오지 못했습니다.'));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  }
                  final schedules = snapshot.data!.docs
                      .map(
                        (QueryDocumentSnapshot doc) => ScheduleModel.fromJson(
                        json: doc.data() as Map<String, dynamic>),
                  )
                      .toList();
                  return ListView.builder(
                      itemCount: schedules.length,
                      itemBuilder: (context, i) {
                        final schedule = schedules[i];
                        return Dismissible(
                          key: ObjectKey(schedule.id),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (DismissDirection direction) {
                            FirebaseFirestore.instance
                                .collection('schedule')
                                .doc(schedule.id)
                                .delete();
                          },
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isDismissible: true,
                                isScrollControlled: true,
                                builder: (_) => ScheduleBottomSheet(
                                  selectedDate: selectedDate,
                                  isNewSchedule: !isNewSchedule,
                                  id: schedule.id,
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 8, left: 8, right: 8),
                              child: ScheduleCard(
                                  startTime: schedule.startTime,
                                  endTime: schedule.endTime,
                                  content: schedule.content),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }

  void onDaySelected(
      DateTime selectedDate,
      DateTime focusedDate,
      ) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
