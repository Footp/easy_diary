import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime selectedDay = pickDate;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 0.5),
        ),
      ),
      child: Obx(
        () => Column(
          children: [
            //GetX 캘린더 업데이트용 SizedBox
            c.languageCount.value == 0 ? const SizedBox() : const SizedBox(),
            c.pageCount.value == 0 ? const SizedBox() : const SizedBox(),
            c.dailyMemo.isEmpty ? const SizedBox() : const SizedBox(),
            c.dailyDiary.isEmpty ? const SizedBox() : const SizedBox(),
            TableCalendar(
              locale: 'ko_KR',
              focusedDay: selectedDay,
              firstDay: DateTime.utc(2022),
              lastDay: DateTime.utc(2030),
              headerVisible: true,
              headerStyle: const HeaderStyle(
                titleCentered: true,
                formatButtonVisible: false,
              ),
              onHeaderTapped: (focusedDay) {
                setState(() {
                  selectedDay = DateTime.now();
                });
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  this.selectedDay = selectedDay;
                  dateTrans(selectedDay);
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(selectedDay, day);
              },
              calendarFormat: c.calFm.value,
              eventLoader: (day) {
                String date = DateFormat('yyyy/MM/dd (E)', 'ko').format(day);
                return c.pageCount.value == 0
                    ? c.dailyMemo.keys
                        .where((event) => c.languageCount.value == 0
                            ? isSameMemoKr(event, date)
                            : isSameMemoEn(event, date))
                        .toList()
                    : c.dailyDiary.keys
                        .where((event) => isSameDiary(event, date))
                        .toList();
              },
              calendarStyle: CalendarStyle(
                markerDecoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                weekendTextStyle: const TextStyle(
                  color: Colors.red,
                ),
                todayDecoration: const BoxDecoration(
                    color: Color.fromARGB(255, 84, 107, 238),
                    shape: BoxShape.circle),
                selectedDecoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    shape: BoxShape.circle),
                selectedTextStyle: const TextStyle(color: Colors.black),
              ),
              weekendDays: const [DateTime.sunday],
            ),
          ],
        ),
      ),
    );
  }
}

bool isSameMemoKr(a, b) {
  final c = Get.put(Controller());
  if (a == null || b == null) {
    return false;
  } else if (a == b) {
    int count = 0;
    for (int i = 0; i < c.dailyMemo[b].length; i++) {
      if (c.dailyMemo[b][i]['memo'].length != 0) {
        count++;
      }
    }
    return count > 0;
  }
  return false;
}

bool isSameMemoEn(a, b) {
  final c = Get.put(Controller());
  if (a == null || b == null) {
    return false;
  } else if (a == b) {
    int count = 0;
    for (int i = 0; i < c.dailyMemo[b].length; i++) {
      if (c.dailyMemo[b][i]['eMemo'].length != 0) {
        count++;
      }
    }
    return count > 0;
  }
  return false;
}

bool isSameDiary(a, b) {
  final c = Get.put(Controller());
  if (a == null || b == null) {
    return false;
  } else if (a == b) {
    int count = 0;
    if (c.dailyDiary[b].runtimeType != Null) {
      if (c.dailyDiary[b][c.languageCount.value].runtimeType != Null) {
        for (int i = 0;
            i < c.dailyDiary[b][c.languageCount.value].length;
            i++) {
          if (c.dailyDiary[b][c.languageCount.value][i].length != 0) {
            count++;
          }
        }
      }
    }
    return count > 0;
  }
  return false;
}
