import 'package:easy_diary/utils/getx_controller.dart';
import 'package:easy_diary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageChangeBtn extends StatelessWidget {
  const LanguageChangeBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        c.languageCount.value = c.languageCount.value == 0 ? 1 : 0;
      },
      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: c.languageCount.value == 0 ? null : Colors.white,
            border: Border.all(width: 0.2, color: Colors.black),
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8.0),
            ),
          ),
          child: Center(
            child: Text(
              c.languageCount.value == 0 ? '한글' : '영어',
              style: textStyle_basic,
            ),
          ),
        ),
      ),
    );
  }
}
