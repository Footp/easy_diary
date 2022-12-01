import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoSelectAll extends StatelessWidget {
  const MemoSelectAll({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        if (c.dailyMemo[c.pickDate.value].runtimeType == Null) {
          null;
        } else if (c.dailyMemo[c.pickDate.value].length == c.sendList.length) {
          c.sendList.clear();
        } else {
          c.sendList.clear();
          for (int i = 0; i < c.dailyMemo[c.pickDate.value].length; i++) {
            c.sendList.add(i);
          }
        }
      },
      child: const Center(
        child: Icon(
          Icons.done_all,
          size: 32,
          color: Colors.black,
        ),
      ),
    );
  }
}
