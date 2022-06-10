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
    var errorMessage = '';

    if (json['message'] is List) {
      errorMessage = List.from(json['message']).join(', ');
    } else if (json['message'] != null) {
      errorMessage = json['message'];
    }
    return ApiErrorResponse(
      statusCode: json["statusCode"],
      message: errorMessage,
      error: json["error"],
    );
  }
}
