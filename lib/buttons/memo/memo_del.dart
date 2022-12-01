import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoDelBtn extends StatelessWidget {
  const MemoDelBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: AlertDialog(
              alignment: Alignment.bottomCenter,
              insetPadding: EdgeInsets.zero,
              content: SizedBox(
                height: 96,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('메모를 삭제하시겠습니까?'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                List extraList = [];
                                c.dailyMemo[c.pickDate.value] == Null
                                    ? null
                                    : extraList = c.dailyMemo[c.pickDate.value];
                                extraList.removeAt(index);
                                c.dailyMemo[c.pickDate.value] = extraList;
                                hiveDataPut('memo', c.dailyMemo);
                                Navigator.pop(context);
                              },
                              child: const Text('삭제'),
                            ),
                            const SizedBox(width: 48),
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('취소'),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      child: const SizedBox(
        child: Icon(
          Icons.delete_outline,
          size: 24,
        ),
      ),
    );
  }
}
