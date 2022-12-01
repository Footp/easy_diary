import 'package:easy_diary/utils/func.dart';
import 'package:flutter/material.dart';

class MemoCopyBtn extends StatelessWidget {
  const MemoCopyBtn({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        copyClip(context, index);
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
