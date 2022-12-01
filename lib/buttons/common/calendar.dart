import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ShowCalendar extends StatefulWidget {
  const ShowCalendar({super.key});

  @override
  State<ShowCalendar> createState() => _ShowCalendarState();
}

class _ShowCalendarState extends State<ShowCalendar> {
  DateTime selectedDay = pickDate;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 0.5),
        ),
      ),
      child: Obx(
        () => TableCalendar(
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
              print(selectedDay);
            });
          },
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              this.selectedDay = selectedDay;
              print(selectedDay);
              dateTrans(selectedDay);
            });
          },
          selectedDayPredicate: (day) {
            return isSameDay(selectedDay, day);
          },
          calendarFormat: c.calFm.value,
          eventLoader: (day) {
            String extra = DateFormat('yyyy/MM/dd (E)', 'ko').format(day);
            return c.dailyMemo.keys
                .where((event) => isSameDay(event, day))
                .toList();
          },
        ),
      ),
    );
  }
}
