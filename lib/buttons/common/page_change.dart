import 'package:easy_diary/utils/getx_controller.dart';
import 'package:easy_diary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PageChangeBtn extends StatelessWidget {
  const PageChangeBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: c.pageCount.value == 0 ? Colors.white : null,
                border: c.pageCount.value == 0
                    ? Border.all(
                        width: 0.2,
                      )
                    : null,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  '메모',
                  style: textStyle_basic,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: c.pageCount.value == 1 ? Colors.white : null,
                border: c.pageCount.value == 1
                    ? Border.all(
                        width: 0.2,
                      )
                    : null,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(
                child: Text(
                  '일기',
                  style: textStyle_basic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
