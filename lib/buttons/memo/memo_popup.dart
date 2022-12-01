import 'package:easy_diary/buttons/memo/memo_copy.dart';
import 'package:easy_diary/buttons/memo/memo_del.dart';
import 'package:easy_diary/buttons/memo/memo_engplus.dart';
import 'package:easy_diary/buttons/memo/memo_time.dart';
import 'package:flutter/material.dart';

class MemoPopupMenu extends StatelessWidget {
  const MemoPopupMenu({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: AlertDialog(
        alignment: Alignment.bottomCenter,
        insetPadding: EdgeInsets.zero,
        contentPadding: const EdgeInsets.all(8.0),
        content: SizedBox(
          height: 48,
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: MemoTimeBtn(index: index),
              ),
              const VerticalDivider(
                width: 8,
                color: Colors.black45,
              ),
              Expanded(
                child: MemoDelBtn(index: index),
              ),
              const VerticalDivider(
                width: 8,
                color: Colors.black45,
              ),
              Expanded(
                child: MemoCopyBtn(index: index),
              ),
              const VerticalDivider(
                width: 8,
                color: Colors.black45,
              ),
              Expanded(
                child: EngPlusBtn(index: index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
