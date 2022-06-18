class ApiResponse<T> {
  bool success;
  T data;
  String message;
  int responseCode;

  ApiResponse({
    required this.success,
    required this.data,
    required this.message,
    required this.responseCode,
  });
}
