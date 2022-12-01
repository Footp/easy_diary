import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:easy_diary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoCreateBtn extends StatelessWidget {
  const MemoCreateBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          alignment: Alignment.bottomCenter,
          insetPadding: EdgeInsets.zero,
          content: SizedBox(
            height: 70,
            width: size.width,
            child: TextField(
              enabled: true,
              autofocus: true,
              maxLength: 50,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: textStyle_basic,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  DateTime? date = DateTime.now();
                  String extraTime = timeConvert(date);
                  Map<String, String> createMemo = {
                    'time': extraTime,
                    'memo': value,
                    'eMemo': '',
                  };
                  List extraList = [];
                  c.dailyMemo[c.pickDate.value].runtimeType == Null
                      ? null
                      : extraList = c.dailyMemo[c.pickDate.value]!;

                  extraList.add(createMemo);
                  c.dailyMemo[c.pickDate.value] = extraList;
                  hiveDataPut('memo', c.dailyMemo);
                }
                Navigator.pop(context);
                scrollToMaxDown();
              },
            ),
          ),
        ),
      ),
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
