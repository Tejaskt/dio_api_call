// This is YOUR model — not Firebase's User class.
// The rest of your app depends on this, never on firebase_auth directly.
// If you ever switch from Firebase to another auth provider,
// you only change AuthService, not your whole app.
class FirebaseUser {
  final String uid;
  final String name;
  final String email;
  final String image;
  final String provider; // "google.com" or "facebook.com"

  FirebaseUser({
    required this.uid,
    required this.name,
    required this.email,
    required this.image,
    required this.provider,
  });

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'photoUrl': image,
    'provider': provider,
  };

  factory FirebaseUser.fromJson(Map<String, dynamic> json) => FirebaseUser(
    uid: json['uid'],
    name: json['name'],
    email: json['email'],
    image: json['photoUrl'],
    provider: json['provider'],
  );
}