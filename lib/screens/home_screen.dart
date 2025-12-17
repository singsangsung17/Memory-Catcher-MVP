import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/memory_button.dart';
import '../models/memory_task.dart';
import '../repositories/memory_task_repository.dart';
import 'task_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _repository = MemoryTaskRepository();
  int _taskCount = 0;

  @override
  void initState() {
    super.initState();
    _refreshCount();
  }

  void _refreshCount() {
    setState(() {
      _taskCount = _repository.getTasks().length;
    });
  }

  /// 🔥 這就是我們說的 `_handleMemoryButtonPress()`
  /// 模擬「剛剛說了一串話 → 被整理成一句提醒」
  void _handleMemoryButtonPress() {
    final now = DateTime.now();
    final newId = now.millisecondsSinceEpoch.toString();

    // 你剛剛隨口說的話（原始語音內容的感覺）
    final rawUtterances = [
      '剛剛跟媽媽說，月底前要確認機票跟住宿。',
      '在跟同學聊天的時候，想到畢業旅行報名期限快到了。',
      '你嘴巴念著：回去要記得把報告上傳 Moodle。',
      '滑 IG 的時候，你說：這個投資觀念等等要記一下。',
      '走路時自言自語：禮拜五記得預約牙醫。'
    ];

    // 系統幫你整理好的「一句話摘要」
    final summaries = [
      '月底前確認機票與住宿。',
      '留意畢旅報名期限，回去查一下時間。',
      '回家後記得把報告上傳 Moodle。',
      '整理剛剛看到的投資觀念，稍後花點時間記錄。',
      '本週五預約牙醫門診。'
    ];

    // 看起來比較像「提醒模式」
    final reminderPresets = [
      '今天晚點提醒我',
      '明天早上',
      '這週內',
      '週末有空時',
      '稍後提醒'
    ];

    final random = Random();
    final i = random.nextInt(rawUtterances.length);

    final newTask = MemoryTask(
      id: newId,
      title: summaries[i],          // 列表上看到的是這個（整理好的摘要）
      description: rawUtterances[i], // 點進去看到「你原本說的內容」
      createdAt: now,
      reminderPreset: reminderPresets[i],
    );

    _repository.addTask(newTask);
    _refreshCount();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('已幫你把剛剛那段話變成一句提醒 ✨'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Catcher'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TaskListScreen(),
                ),
              );
              // 從列表頁回來時，更新記憶數量
              _refreshCount();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔘 把這個 callback 傳進 MemoryButton
            MemoryButton(onPressed: _handleMemoryButtonPress),
            const SizedBox(height: 32),
            const Text(
              'Tap to capture the moment',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              'You have $_taskCount memories',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
