import 'package:easy_diary/utils/getx_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DiaryCopyBtn extends StatelessWidget {
  const DiaryCopyBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return GestureDetector(
      onTap: () {
        Clipboard.setData(
          ClipboardData(
              text: c.dailyDiary[c.pickDate.value][c.languageCount.value]
                  [index]),
        ).then((_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              duration: Duration(seconds: 1),
              content: Text('클립보드에 복사되었습니다.'),
            ),
          );
        });
        Navigator.pop(context);
      },
      child: const SizedBox(
        child: Icon(
          Icons.copy,
          size: 24,
        ),
      ),
    );
  }
}
