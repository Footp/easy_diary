import 'package:easy_diary/buttons/common/bottom_bar.dart';
import 'package:easy_diary/buttons/common/calendar.dart';
import 'package:easy_diary/buttons/memo/memo_selectall.dart';
import 'package:easy_diary/screens/diary_body.dart';
import 'package:easy_diary/screens/memo_body.dart';
import 'package:easy_diary/utils/func.dart';
import 'package:easy_diary/utils/getx_controller.dart';
import 'package:easy_diary/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initialization(null);

  runApp(
    const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '쉬운일기',
      home: MyApp(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ko', 'KR'),
      ],
      locale: Locale('ko'),
    ),
  );
  FlutterNativeSplash.remove();
}

// Hive 저장소에서 불러오기
Future initialization(BuildContext? context) async {
  await Hive.initFlutter();
  await Hive.openBox('EasyDiary');
  await Future.delayed(
    const Duration(seconds: 3),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(Controller());
    pickDate = DateTime.now();
    dateTrans(pickDate);
    
    hiveDataGet();
    Hive.box('EasyDiary').clear();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffE6E4E9),
          elevation: 1,
          centerTitle: false,
          title: Obx(
            () => Text(
              c.pickDate.value,
              style: textStyle_title,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 0.1,
                    color: Colors.black,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(child: diaryDay()),
                      Expanded(child: diaryWeek()),
                      Expanded(child: diaryMonth()),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        body: Obx(
          () => Column(
            children: [
              Expanded(
                child: Container(
                  color: c.selectMode.value == false
                      ? Colors.white
                      : Colors.black26,
                  child: Column(
                    children: [
                      SizedBox(
                        child:
                            c.calVi.value == true ? const ShowCalendar() : null,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: c.pageCount.value == 0
                              ? const MemoBody()
                              : const DiaryBody(),
                        ),
                      ),
                      c.selectMode.value == false
                          ? const SizedBox()
                          : SizedBox(
                              height: 60,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        c.sendList.isEmpty
                                            ? '전송할 메모를 선택해주세요.'
                                            : c.dailyMemo[c.pickDate.value]
                                                        .length !=
                                                    c.sendList.length
                                                ? '${c.dailyMemo[c.pickDate.value].length}개 중 ${c.sendList.length}개의 메모가 선택되었습니다.'
                                                : '모든 메모가 선택되었습니다.',
                                        style: textStyle_basic,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 80,
                                    child: MemoSelectAll(),
                                  )
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const BottomNaviBar(),
            ],
          ),
        ),
      ),
    );
  }
}
