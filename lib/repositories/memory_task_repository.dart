import '../models/memory_task.dart';

class MemoryTaskRepository {
  static final MemoryTaskRepository _instance = MemoryTaskRepository._internal();
  factory MemoryTaskRepository() => _instance;
  MemoryTaskRepository._internal();

  final List<MemoryTask> _tasks = [];

  List<MemoryTask> getTasks() {
    return List.unmodifiable(_tasks);
  }

  void addTask(MemoryTask task) {
    _tasks.insert(0, task); // Add to top
  }

  void updateTask(MemoryTask updatedTask) {
    final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  MemoryTask? getTaskById(String id) {
    try {
      return _tasks.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }
}
class MemoryTaskRepository {
  final List<MemoryTask> _tasks = [];

  List<MemoryTask> get tasks => List.unmodifiable(_tasks);

  void add(MemoryTask task) {
    _tasks.insert(0, task);
  }

  // 給 Memory Key / 常駐通知用的快速新增
  void addFromMemoryKey(MemoryTask task) {
    _tasks.insert(0, task);
    // 之後如果要同步到本地儲存 / 雲端，也可以都集中在這個 function 做
  }
}
