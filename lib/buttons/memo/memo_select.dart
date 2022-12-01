import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoSelectBtn extends StatelessWidget {
  const MemoSelectBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        c.selectMode.value = c.selectMode.value == false ? true : false;
        c.sendList.clear();
      },
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(8.0),
        ),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: c.selectMode.value == false ? null : Colors.white,
              border: Border.all(width: 0.2, color: Colors.black),
            ),
            child: Center(
              child: Text(
                c.selectMode.value == false ? '전송' : '취소',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
