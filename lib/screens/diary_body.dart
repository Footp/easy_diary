import 'package:easy_diary/buttons/diary/diary_popup.dart';
import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiaryBody extends StatelessWidget {
  const DiaryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Obx(
      () => ListView.builder(
        controller: c.scrollController.value,
        itemCount: c.dailyDiary[c.pickDate.value].runtimeType == Null
            ? 0
            : c.dailyDiary[c.pickDate.value][c.languageCount.value].length,
        itemBuilder: (context, index) => Obx(
          () => Container(
            decoration: c.textEditMode.value == false
                ? null
                : const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.2,
                      ),
                    ),
                  ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DiaryPopupMenu(index: index),
                Obx(
                  () => Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: c.textEditMode.value == false
                          ? TextFieldMode(index, false)
                          : TextFieldMode(index, true),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  TextField TextFieldMode(int index, bool isbool) {
    final c = Get.put(Controller());
    return TextField(
      autofocus: isbool,
      enabled: isbool,
      maxLines: null,
      controller: TextController(
        text: c.dailyDiary[c.pickDate.value][c.languageCount.value][index],
      ),
      decoration: const InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(top: 8.0),
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
        height: 1.5,
      ),
      onChanged: (String value) {
        c.dailyDiary[c.pickDate.value][c.languageCount.value][index] = value;
        hiveDataPut('diary', c.dailyDiary);
      },
    );
  }
}

class TextController extends TextEditingController {
  TextController({required String text}) {
    this.text = text;
  }

  @override
  set text(String newText) {
    value = value.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
        composing: TextRange.empty);
  }
}
