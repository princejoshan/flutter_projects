import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String description;
  final bool isCompleted;

  const Task({
    required this.id,
    required this.description,
    this.isCompleted = false,
  });

  Task copyWith({String? id, String? description, bool? isCompleted}) {
    return Task(
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, description, isCompleted];
}