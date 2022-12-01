import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DiaryAllCopyBtn extends StatelessWidget {
  const DiaryAllCopyBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        String extraString =
            c.dailyDiary[c.pickDate.value][c.languageCount.value].join('\n');
        Clipboard.setData(
          ClipboardData(text: extraString),
        ).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 1),
              content: Text('클립보드에 복사되었습니다.'),
            ),
          );
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 0.2, color: Colors.black),
          borderRadius: const BorderRadius.all(
            Radius.circular(8.0),
          ),
        ),
        child: const Center(
          child: Text(
            '다이어리 복사',
            style: TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
