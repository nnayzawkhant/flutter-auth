class LoginResponseModel {
  final String accessToken;

  LoginResponseModel({required this.accessToken});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['accessToken'] ?? '', // Default to an empty string if token is null
    );
  }
}
