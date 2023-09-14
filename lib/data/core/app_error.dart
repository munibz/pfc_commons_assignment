class AppError {
  final AppErrorType appErrorType;

  const AppError(this.appErrorType);
}

enum AppErrorType { api, network, database }
