import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:easy_diary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EngPlusBtn extends StatelessWidget {
  const EngPlusBtn({
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
              height: 340,
              width: size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    '원본',
                    style: TextStyle(color: Colors.blue),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: 48,
                    child: SelectableText(
                      c.dailyMemo[c.pickDate.value][index]['memo'],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.black45, thickness: 1.0),
                  const SizedBox(height: 24),
                  const Text('영어', style: TextStyle(color: Colors.blue)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextField(
                    maxLines: 3,
                    autofocus: true,
                    maxLength: 200,
                    enabled: true,
                    controller: TextEditingController(
                      text: c.dailyMemo[c.pickDate.value][index]['eMemo'],
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(
                        8.0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 1,
                          color: Colors.black45,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    style: textStyle_basic,
                    onChanged: (value) {
                      List extraList = [];
                      extraList = c.dailyMemo[c.pickDate.value];
                      extraList[index]['eMemo'] = value;
                      c.dailyMemo[c.pickDate.value] = extraList;
                      hiveDataPut('memo', c.dailyMemo);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: const SizedBox(
        child: Text(
          'Eng+',
          style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
