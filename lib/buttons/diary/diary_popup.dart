import 'package:easy_diary/buttons/diary/diary_copy.dart';
import 'package:easy_diary/buttons/diary/diary_del.dart';
import 'package:easy_diary/buttons/diary/diary_move.dart';
import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryPopupMenu extends StatelessWidget {
  const DiaryPopupMenu({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Obx(
      () => GestureDetector(
        onTap: () {
          diaryMoveCount = index;
          showDialog(
            context: context,
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: AlertDialog(
                alignment: Alignment.bottomCenter,
                insetPadding: EdgeInsets.zero,
                contentPadding: const EdgeInsets.all(8.0),
                content: SizedBox(
                  height: 48,
                  width: 300,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: DiaryMoveUpBtn(index: index)),
                      const VerticalDivider(
                        width: 8,
                        color: Colors.black45,
                      ),
                      Expanded(child: DiaryDelBtn(index: index)),
                      const VerticalDivider(
                        width: 8,
                        color: Colors.black45,
                      ),
                      Expanded(child: DiaryCopyBtn(index: index)),
                      const VerticalDivider(
                        width: 8,
                        color: Colors.black45,
                      ),
                      Expanded(child: DiaryMoveDnBtn(index: index)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        child: c.textEditMode.value == false
            ? const SizedBox(
                width: 48,
              )
            : const SizedBox(
                height: 48,
                width: 48,
                child: Icon(
                  Icons.more_vert,
                  size: 20,
                  color: Colors.black45,
                ),
              ),
      ),
    );
  }
}
