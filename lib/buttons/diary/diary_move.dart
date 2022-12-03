// ignore_for_file: invalid_use_of_protected_member

import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryMoveUpBtn extends StatelessWidget {
  const DiaryMoveUpBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        if (diaryMoveCount != 0) {
          List extraList = c.dailyDiary[c.pickDate.value];
          extraList[c.languageCount.value].insert(diaryMoveCount - 1,
              extraList[c.languageCount.value][diaryMoveCount]);
          extraList[c.languageCount.value].removeAt(diaryMoveCount + 1);
          c.dailyDiary[c.pickDate.value] = extraList;
          diaryMoveCount--;
          hiveDataPut('diary', c.dailyDiary.value);
        }
      },
      child: const SizedBox(
        child: Icon(Icons.keyboard_arrow_up),
      ),
    );
  }
}

class DiaryMoveDnBtn extends StatelessWidget {
  const DiaryMoveDnBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        if (diaryMoveCount !=
            c.dailyDiary[c.pickDate.value][c.languageCount.value].length - 1) {
          List extraList = c.dailyDiary[c.pickDate.value];
          extraList[c.languageCount.value].insert(diaryMoveCount + 2,
              extraList[c.languageCount.value][diaryMoveCount]);
          extraList[c.languageCount.value].removeAt(diaryMoveCount);
          c.dailyDiary[c.pickDate.value] = extraList;
          diaryMoveCount++;
          hiveDataPut('diary', c.dailyDiary.value);
        }
      },
      child: const SizedBox(
        child: Icon(Icons.keyboard_arrow_down),
      ),
    );
  }
}
