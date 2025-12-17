import 'package:flutter/material.dart';
import '../models/memory_task.dart';
import '../repositories/memory_task_repository.dart';

class TaskDetailScreen extends StatefulWidget {
  final String taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  final _repository = MemoryTaskRepository();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String _reminderPreset = "Later today";
  MemoryTask? _task;

  final _reminderOptions = ["Later today", "Tomorrow", "Custom note only"];

  @override
  void initState() {
    super.initState();
    _task = _repository.getTaskById(widget.taskId);
    if (_task != null) {
      _titleController = TextEditingController(text: _task!.title);
      _descriptionController = TextEditingController(text: _task!.description);
      _reminderPreset = _task!.reminderPreset;
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _save() {
    if (_task != null) {
      final updatedTask = MemoryTask(
        id: _task!.id,
        title: _titleController.text,
        description: _descriptionController.text,
        createdAt: _task!.createdAt,
        reminderPreset: _reminderPreset,
      );
      _repository.updateTask(updatedTask);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Task not found')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Memory'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _reminderPreset,
              decoration: const InputDecoration(
                labelText: 'Reminder',
                border: OutlineInputBorder(),
              ),
              items: _reminderOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _reminderPreset = newValue!;
                });
              },
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Save Changes'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
