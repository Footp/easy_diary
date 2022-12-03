import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class Controller extends GetxController {
  var scrollController = ScrollController().obs;

  // 캘린더 관련
  var calFm = CalendarFormat.week.obs; // 달력포맷
  var calVi = true.obs; // 캘린더 활성/비활성
  RxInt dailyFormat = 1.obs;
  RxString pickDate = ''.obs; // 선택날짜 표시

  // 데이터 관련
  RxMap dailyMemo = {}.obs;
  RxMap dailyDiary = {}.obs;
  RxList sendList = [].obs;

  // 페이지 관련
  RxInt pageCount = 0.obs;
  RxInt languageCount = 0.obs;

  // 다이어리 체크박스
  RxBool checkKr = false.obs;
  RxBool checkEn = false.obs;

  // 모드변경 관련
  RxBool selectMode = false.obs;
  RxBool textEditMode = false.obs;

  RxBool calendarDummy = false.obs;
}
