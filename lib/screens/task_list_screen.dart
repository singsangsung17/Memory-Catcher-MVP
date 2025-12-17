import 'package:flutter/material.dart';
import '../repositories/memory_task_repository.dart';
import '../widgets/task_list_item.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final _repository = MemoryTaskRepository();

  @override
  Widget build(BuildContext context) {
    final tasks = _repository.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Memories'),
      ),
      body: tasks.isEmpty
          ? const Center(child: Text('No memories yet.'))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskListItem(
                  task: task,
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailScreen(taskId: task.id),
                      ),
                    );
                    setState(() {}); // Refresh list on return
                  },
                );
              },
            ),
    );
  }
}
