class MemoryTask {
  final String id;
  final String title;    // 標題範例
  final String summary;  // 待實作：未來將串接 LLM API，目前使用模擬資料 (Mock Data) 驗證介面
  final DateTime createdAt;  // 建立時間
  final DateTime remindAt;   // 提醒時間
  final String source;       // 'memory_key' / 'manual' 之類

  MemoryTask({
    required this.id,
    required this.title,
    required this.summary,
    required this.createdAt,
    required this.remindAt,
    required this.source,
  });
}

