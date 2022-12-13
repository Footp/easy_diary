// ignore_for_file: invalid_use_of_protected_member

import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:easy_diary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class MemoTimeBtn extends StatelessWidget {
  const MemoTimeBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            alignment: Alignment.bottomCenter,
            insetPadding: EdgeInsets.zero,
            content: SizedBox(
              height: 60,
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  timeField(c, context, 0, 2),
                  const SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(':'),
                    ),
                  ),
                  timeField(c, context, 3, 5),
                  const SizedBox(
                    width: 30,
                    child: Center(
                      child: Text(':'),
                    ),
                  ),
                  timeField(c, context, 6, 8),
                ],
              ),
            ),
          ),
        );
      },
      child: const SizedBox(
        height: double.infinity,
        child: Icon(
          Icons.timer_outlined,
          size: 24,
        ),
      ),
    );
  }

  SizedBox timeField(Controller c, BuildContext context, int a, int b) {
    return SizedBox(
      width: 30,
      child: Center(
        child: TextField(
          autofocus: true,
          maxLength: 2,
          textAlign: TextAlign.center,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          controller: TextEditingController(
            text: c.dailyMemo[c.pickDate.value][index]['time'].substring(a, b),
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          style: textStyle_basic,
          onChanged: (value) {
            if (value.isNotEmpty) {
              value.length == 1 ? value = '0$value' : null;
              value = value.toString();
              List extraMemoMap = c.dailyMemo[c.pickDate.value];
              extraMemoMap[index]['time'] =
                  extraMemoMap[index]['time'].replaceRange(a, b, value);
              extraMemoMap.sort((a, b) => a['time'].compareTo(b['time']));
              c.dailyMemo.remove(c.pickDate.value);
              c.dailyMemo[c.pickDate.value] = extraMemoMap;
              hiveDataPut('memo', c.dailyMemo.value);
            } else {
              null;
            }
          },
        ),
      ),
    );
  }
}
