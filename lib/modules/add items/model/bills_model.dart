class BillModel {
  final String itemName;
  final int quantity;
  final double rate;
  final double subtotal;
  final double tax;
  final double discount;
  final double total;

  BillModel({
    required this.itemName,
    required this.quantity,
    required this.rate,
    required this.subtotal,
    required this.tax,
    required this.discount,
    required this.total,
  });

  // Convert BillModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'itemName': itemName,
      'quantity': quantity,
      'rate': rate,
      'subtotal': subtotal,
      'tax': tax,
      'discount': discount,
      'total': total,
    };
  }

  factory BillModel.fromMap(Map<String, dynamic> map) {
    return BillModel(
      itemName: map['itemName'],
      quantity: map['quantity'],
      rate: map['rate'],
      subtotal: map['subtotal'],
      tax: map['tax'],
      discount: map['discount'],
      total: map['total'],
    );
  }
}
