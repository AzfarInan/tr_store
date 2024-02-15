class ErrorModel {
  ErrorModel({
    this.message = "Something went wrong! Please try again later.",
    this.code = "500",
    this.stack,
  });

  String? message;
  String? code;
  String? stack;

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json["error"] ?? "Something went wrong! Please try again later.",
      code: json["code"] ?? "500",
      stack: json["stack"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": message,
      "code": code,
      "stack": stack,
    };
  }
}
