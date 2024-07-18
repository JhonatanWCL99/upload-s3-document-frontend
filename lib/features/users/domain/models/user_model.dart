class User {
  String? id;
  final String fullName;
  String? createdAt;

  User({required this.fullName, this.id, this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      createdAt: json['createdAt'],
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
