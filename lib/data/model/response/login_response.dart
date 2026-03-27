class LoginResponse {
  final int id;
  final String username;
  final String accessToken;

  LoginResponse({
    required this.id,
    required this.username,
    required this.accessToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'],
      username: json['username'],
      accessToken: json['accessToken'],
    );
  }

}
