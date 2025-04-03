class RawIngredient {
  final String uid;
  final String name;
  final String image;
  final String quantity;

  const RawIngredient({
    required this.uid,
    required this.name,
    required this.image,
    required this.quantity,
  });

  factory RawIngredient.fromMap(Map<String, String> map) {
    return RawIngredient(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      quantity: map['quantity'] ?? '',
    );
  }

  Map<String, String> toMap() {
    return {'uid': uid, 'name': name, 'image': image, 'quantity': quantity};
  }
}
