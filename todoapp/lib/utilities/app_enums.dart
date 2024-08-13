enum TaskStatus {
  initial,
  success,
  error,
  loading,
  validationSuccess,
  validationFailed
}

extension TaskStatusX on TaskStatus {
  bool get isInitial => this == TaskStatus.initial;

  bool get isSuccess => this == TaskStatus.success;

  bool get isError => this == TaskStatus.error;

  bool get isLoading => this == TaskStatus.loading;

  bool get isValidationSuccess => this == TaskStatus.validationSuccess;

  bool get isValidationFailed => this == TaskStatus.validationFailed;
}