import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryCreatBtn extends StatelessWidget {
  const DiaryCreatBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        c.textEditMode.value = true;
        List extraList = [
          [''],
          ['']
        ];
        c.dailyDiary[c.pickDate.value].runtimeType == Null
            ? null
            : extraList = c.dailyDiary[c.pickDate.value];
        extraList[c.languageCount.value].add('');
        c.dailyDiary[c.pickDate.value] = extraList;
        hiveDataPut('diary', c.dailyDiary);
        scrollToMaxDown();
      },
      child: const Center(
        child: Icon(
          Icons.add_circle_outline,
          size: 40,
          color: Colors.black26,
        ),
      ),
    );
  }
}
