class MemoryTask {
  final String id;
  final String title;        // 短的標題，例如「Memory at 01:41」
  final String summary;      // 語音摘要（假裝是模型幫你整理的）
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
