class FavoritesModel {
  final String id;
  final String userId;
  final String productId;
  DateTime? createdAt;

  FavoritesModel({
    required this.id,
    required this.userId,
    required this.productId,
    this.createdAt,
  });

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
      id: json['id'],
      userId: json['userId'],
      productId: json['productId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'productId': productId,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}