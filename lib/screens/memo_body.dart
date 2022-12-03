// ignore_for_file: invalid_use_of_protected_member

import 'package:easy_diary/buttons/memo/memo_popup.dart';
import 'package:easy_diary/screens/diary_body.dart';
import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:easy_diary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MemoBody extends StatelessWidget {
  const MemoBody({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    Size size = MediaQuery.of(context).size;
    return Obx(
      () => ListView.builder(
        controller: c.scrollController.value,
        itemCount: c.dailyMemo[c.pickDate.value].runtimeType == Null
            ? 0
            : c.dailyMemo[c.pickDate.value].length,
        itemBuilder: (context, index) {
          return GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => MemoPopupMenu(index: index),
                );
              },
              child: Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: c.selectMode.value == false
                        ? null
                        : c.sendList.contains(index) == true
                            ? Colors.white
                            : null,
                    border: const Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.2,
                      ),
                    ),
                  ),
                  height: 60,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: double.infinity,
                          width: 48,
                          child: Text(
                            c.dailyMemo[c.pickDate.value][index]['time']
                                .substring(0, 5),
                            style: textStyle_behind,
                          ),
                        ),
                      ),
                      Obx(
                        () => Expanded(
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            alignment: Alignment.centerLeft,
                            height: double.infinity,
                            width: double.infinity,
                            child: c.languageCount.value == 0
                                ? Text(
                                    c.dailyMemo[c.pickDate.value][index]
                                        ['memo'],
                                    style: textStyle_basic,
                                  )
                                : c.dailyMemo[c.pickDate.value][index]['eMemo']
                                        .isEmpty
                                    ? Text(
                                        c.dailyMemo[c.pickDate.value][index]
                                            ['memo'],
                                        style: textStyle_behind,
                                      )
                                    : Text(
                                        c.dailyMemo[c.pickDate.value][index]
                                            ['eMemo'],
                                        style: textStyle_basic,
                                      ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 8.0),
                        height: double.infinity,
                        width: 16.0,
                        child: Center(
                          child: CircleAvatar(
                            radius: 4.0,
                            backgroundColor: c
                                        .dailyMemo[c.pickDate.value][index]
                                            ['eMemo']
                                        .length ==
                                    0
                                ? Colors.transparent
                                : Colors.redAccent,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              onTap: () => c.selectMode.value == false
                  ? showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        alignment: Alignment.bottomCenter,
                        insetPadding: EdgeInsets.zero,
                        content: SizedBox(
                          height: 70,
                          width: size.width,
                          child: TextField(
                            autofocus: true,
                            maxLength: 50,
                            enabled: true,
                            controller: TextController(
                                text: c.dailyMemo[c.pickDate.value][index]
                                    [languageList[c.languageCount.value]]),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                            style: textStyle_basic,
                            onSubmitted: (value) {
                              List extraList = [];
                              extraList = c.dailyMemo[c.pickDate.value];
                              extraList[index]
                                  [languageList[c.languageCount.value]] = value;
                              c.dailyMemo[c.pickDate.value] = extraList;
                              hiveDataPut('memo', c.dailyMemo.value);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                  : {
                      c.sendList.contains(index) == false
                          ? c.sendList.add(index)
                          : c.sendList.remove(index)
                    });
        },
      ),
    );
  }
}
