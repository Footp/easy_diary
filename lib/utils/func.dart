import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime pickDate = DateTime.now();

Map testData = {
  '2022/11/20': ['fire', 'in', 'the', 'work']
};

// 메모, 다이어리 불러오기
hiveDataGet() {
  final c = Get.put(Controller());
  Hive.box('EasyDiary').get('memo') == null
      ? null
      : c.dailyMemo.value = Hive.box('EasyDiary').get('memo');
  Hive.box('EasyDiary').get('diary') == null
      ? null
      : c.dailyDiary.value = Hive.box('EasyDiary').get('diary');
}

hiveDataPut(String storage, Map data) {
  Hive.box('EasyDiary').put(storage, data);
}

dateTrans(DateTime date) {
  final c = Get.put(Controller());
  pickDate = date;
  c.pickDate.value = DateFormat('yyyy/MM/dd (E)', 'ko').format(pickDate);
  hiveDataGet();
}

// 시간 포맷 변경
String timeConvert(input) {
  String extra = DateFormat('HH:mm:ss').format(input);
  return extra;
}

int diaryMoveCount = 0;

scrollToMaxDown() {
  final c = Get.put(Controller());
  Future.delayed(
    const Duration(milliseconds: 300),
    () => c.scrollController.value.animateTo(
        c.scrollController.value.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear),
  );
}

//- 메모 복사 관련 -//

String clipBoardString = '';

// 시간+메모 합집합
selectText(index) {
  final c = Get.put(Controller());
  String extraTime =
      c.dailyMemo[c.pickDate.value][index]['time'].substring(0, 5);
  String extraMemo = c.dailyMemo[c.pickDate.value][index]['memo'];
  List extraList = [extraTime, extraMemo];
  return clipBoardString = extraList.join(' ');
}

// 메모 클립보드로 복사
copyClip(context, index) {
  Clipboard.setData(
    ClipboardData(text: selectText(index)),
  ).then((_) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 1),
        content: Text('클립보드에 복사되었습니다.'),
      ),
    );
  });
}

List languageList = ['memo', 'eMemo'];

diaryDay() {
  final c = Get.put(Controller());
  return GestureDetector(
    onTap: () {
      c.calVi.value = false;
      c.dailyFormat.value = 0;
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.2,
        ),
        borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(8.0),
        ),
        color: c.dailyFormat.value == 0
            ? const Color(0xffDAD8DC)
            : Colors.transparent,
      ),
      child: const Center(
        child: Text(
          '일',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
    ),
  );
}

diaryWeek() {
  final c = Get.put(Controller());
  return GestureDetector(
    onTap: () {
      c.calVi.value = true;
      c.calFm.value = CalendarFormat.week;
      c.dailyFormat.value = 1;
    },
    child: Container(
      decoration: BoxDecoration(
        color: c.dailyFormat.value == 1
            ? const Color(0xffDAD8DC)
            : Colors.transparent,
        border: const Border.symmetric(
          horizontal: BorderSide(
            color: Colors.black,
            width: 0.2,
          ),
        ),
      ),
      child: const Center(
        child: Text(
          '주',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
    ),
  );
}

diaryMonth() {
  final c = Get.put(Controller());
  return GestureDetector(
    onTap: () {
      c.calVi.value = true;
      c.calFm.value = CalendarFormat.month;
      c.dailyFormat.value = 2;
    },
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.2,
        ),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(8.0),
        ),
        color: c.dailyFormat.value == 2
            ? const Color(0xffDAD8DC)
            : Colors.transparent,
      ),
      child: const Center(
        child: Text(
          '월',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
      ),
    ),
  );
}
