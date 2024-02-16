enum Status {
  initial,
  loading,
  success,
  error,
  noInternet;

  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
  bool get isNoInternet => this == Status.noInternet;
}

class BaseState<T> {
  BaseState({
    this.status,
    this.message,
    this.data,
  });

  BaseState.initial()
      : status = Status.initial,
        message = null,
        data = null;

  BaseState.loading()
      : status = Status.loading,
        message = null,
        data = null;

  final Status? status;
  final String? message;
  final T? data;

  BaseState<T> copyWith({
    Status? status,
    String? message,
    T? data,
  }) {
    return BaseState<T>(
      status: status ?? this.status,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }
}
