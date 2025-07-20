class CartItem {
  final String id;
  final String name;
  final int quantity;
  final double price;
  final double offerPrice;

  CartItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.offerPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
      'offerPrice': offerPrice,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map, String id) {
    return CartItem(
      id: id,
      name: map['name'],
      quantity: map['quantity'],
      price: map['price'],
      offerPrice: map['offerPrice'],
    );
  }
}
