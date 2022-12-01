import 'package:easy_diary/buttons/common/language_change.dart';
import 'package:easy_diary/buttons/common/page_change.dart';
import 'package:easy_diary/buttons/diary/diary_allcopy.dart';
import 'package:easy_diary/buttons/diary/diary_creat.dart';
import 'package:easy_diary/buttons/diary/diary_mode.dart';
import 'package:easy_diary/buttons/memo/memo_creat.dart';
import 'package:easy_diary/buttons/memo/memo_select.dart';
import 'package:easy_diary/buttons/memo/memo_send.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNaviBar extends StatelessWidget {
  const BottomNaviBar({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: const Color(0xffE6E4E9),
      height: 60,
      width: double.infinity,
      child: Obx(
        () => Stack(
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      c.dailyDiary[c.pickDate.value].runtimeType == Null
                          ? c.dailyDiary[c.pickDate.value] = [[], []]
                          : null;
                      c.pageCount.value = c.pageCount.value == 0 ? 1 : 0;
                    },
                    child: Obx(
                      () => Container(
                        width: 144,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.2,
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: c.selectMode.value == false &&
                                c.textEditMode.value == false
                            ? const PageChangeBtn()
                            : c.pageCount.value == 0
                                ? const MemoSendBtn()
                                : const DiaryAllCopyBtn(),
                      ),
                    ),
                  ),
                  Container(
                    width: 144,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 0.2,
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: LanguageChangeBtn(),
                        ),
                        Expanded(
                          child: c.pageCount.value == 0
                              ? const MemoSelectBtn()
                              : const DiaryModeBtn(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            c.pageCount.value == 0
                ? const MemoCreateBtn()
                : const DiaryCreatBtn(),
          ],
        ),
      ),
    );
  }
}
