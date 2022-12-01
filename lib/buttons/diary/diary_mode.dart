import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryModeBtn extends StatelessWidget {
  const DiaryModeBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () =>
          c.textEditMode.value = c.textEditMode.value == false ? true : false,
      child: ClipRRect(
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(8.0),
        ),
        child: Obx(
          () => Container(
            decoration: BoxDecoration(
              color: c.textEditMode.value == false ? null : Colors.white,
              border: Border.all(width: 0.2, color: Colors.black),
            ),
            child: Center(
              child: Text(
                c.textEditMode.value == false ? '편집' : '취소',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
