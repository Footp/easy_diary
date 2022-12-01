import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:easy_diary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoSendBtn extends StatelessWidget {
  const MemoSendBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Obx(
      () => GestureDetector(
        onTap: () {
          {
            c.sendList.sort();
            if (c.sendList.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('선택한 메모가 없습니다.'),
                  duration: Duration(seconds: 1),
                ),
              );
            } else {
              c.dailyDiary[c.pickDate.value].runtimeType == Null
                  ? c.dailyDiary[c.pickDate.value] = [[], []]
                  : null;
              {
                // 체크된 한글 다이어리 전송
                for (int i = 0; i < c.sendList.length; i++) {
                  c.dailyDiary[c.pickDate.value][c.languageCount.value].add(
                    c.dailyMemo[c.pickDate.value][c.sendList[i]]
                        [languageList[c.languageCount.value]],
                  );
                }
              }
              {
                // 첫번째 빈줄 삭제
                c.dailyDiary[c.pickDate.value][c.languageCount.value].length >
                            1 &&
                        c.dailyDiary[c.pickDate.value][c.languageCount.value]
                                .first.length ==
                            0
                    ? c.dailyDiary[c.pickDate.value][c.languageCount.value]
                        .removeAt(0)
                    : null;
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('메모가 전송되었습니다.'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: '이동하기',
                      onPressed: () {
                        c.pageCount.value = 1;
                        c.selectMode.value = false;
                        c.sendList.clear();
                      }),
                ),
              );
            }
          }
        },
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: c.languageCount.value == 0 ? null : Colors.white,
            border: c.languageCount.value == 1
                ? null
                : Border.all(
                    width: 0.2,
                  ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Center(
            child: Text(
              c.languageCount.value == 0 ? '한글메모 전송' : '영어메모 전송',
              style: textStyle_basic,
            ),
          ),
        ),
      ),
    );
  }
}
