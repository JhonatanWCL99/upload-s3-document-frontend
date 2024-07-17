class User {
  String? id;
  final String fullName;
  String? createdAt;

  User({required this.fullName, String? id, String? createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String?,
      fullName: json['fullName'] as String,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'createdAt': createdAt,
    };
  }
}
