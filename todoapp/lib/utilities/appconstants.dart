class AppConstants {
  static const String pendingTasks = "PendingTasks";
  static const String completedTasks = "CompletedTasks";
}

enum Status {
  added,
  pending,
  completed,
  deleted,
}

extension StatusExtension on Status {
  String get asString {
    switch (this) {
      case Status.pending:
        return 'Tasks Moved to Pending State';
      case Status.completed:
        return 'Tasks completed';
      case Status.deleted:
        return 'Tasks deleted';
      case Status.added:
        return 'Tasks added';
      default:
        return '';
    }
  }
}