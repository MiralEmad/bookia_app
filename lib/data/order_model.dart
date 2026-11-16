class OrderItem {
  const OrderItem({
    required this.bookId,
    required this.quantity,
    required this.price,
  });

  final String bookId;
  final int quantity;
  final int price;

  Map<String, dynamic> toMap() =>
      {'bookId': bookId, 'quantity': quantity, 'price': price};

  factory OrderItem.fromMap(Map m) => OrderItem(
        bookId: m['bookId'] as String,
        quantity: m['quantity'] as int,
        price: m['price'] as int,
      );
}

class OrderModel {
  const OrderModel({
    required this.id,
    required this.fullName,
    required this.address,
    required this.phone,
    required this.governorateId,
    required this.items,
    required this.total,
    required this.createdAt,
  });

  final String id;
  final String fullName;
  final String address;
  final String phone;
  final String governorateId;
  final List<OrderItem> items;
  final int total;
  final DateTime createdAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'fullName': fullName,
        'address': address,
        'phone': phone,
        'governorateId': governorateId,
        'items': items.map((i) => i.toMap()).toList(),
        'total': total,
        'createdAt': createdAt.millisecondsSinceEpoch,
      };

  factory OrderModel.fromMap(Map m) => OrderModel(
        id: m['id'] as String,
        fullName: m['fullName'] as String,
        address: m['address'] as String,
        phone: m['phone'] as String,
        governorateId: m['governorateId'] as String,
        items: (m['items'] as List).map((e) => OrderItem.fromMap(e as Map)).toList(),
        total: m['total'] as int,
        createdAt: DateTime.fromMillisecondsSinceEpoch(m['createdAt'] as int),
      );
}