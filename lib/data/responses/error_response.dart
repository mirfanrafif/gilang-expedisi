class ApiErrorResponse {
  ApiErrorResponse({
    required this.statusCode,
    required this.message,
    required this.error,
  });

  final int? statusCode;
  final String? message;
  final String? error;

  factory ApiErrorResponse.fromJson(Map<String, dynamic> json) {
    return ApiErrorResponse(
      statusCode: json["statusCode"],
      message: json["message"],
      error: json["error"],
    );
  }
}
