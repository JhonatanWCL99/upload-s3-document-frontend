import 'package:upload_file_frontend/features/users/domain/models/user_model.dart';

class Document {
  final String? id;
  final String url;
  final String? createdAt;
  final User uploadedBy;

  Document({
    this.id,
    required this.url,
    this.createdAt,
    required this.uploadedBy,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['_id'],
      url: json['url'],
      createdAt: json['createdAt'],
      uploadedBy: User.fromJson(json['uploadedBy']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'url': url,
      'createdAt': createdAt,
      'uploadedBy': (uploadedBy).toJson(),
    };
  }
}
