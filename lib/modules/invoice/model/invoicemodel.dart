import '../../add items/model/bills_model.dart';

class InvoiceModel {
  String customerName;
  double totalAmount;
  double balanceAmount;
  String date;
  String invoiceNumber;
  List<BillModel> items;

  InvoiceModel({
    required this.customerName,
    required this.totalAmount,
    required this.balanceAmount,
    required this.date,
    required this.invoiceNumber,
    required this.items,
  });

 
  Map<String, dynamic> toMap() {
    return {
      'customerName': customerName,
      'totalAmount': totalAmount,
      'balanceAmount': balanceAmount,
      'date': date,
      'invoiceNumber': invoiceNumber,
      'items': items.map((item) => item.toMap()).toList(),
    };
  }

  
  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      customerName: map['customerName'],
      totalAmount: map['totalAmount'],
      balanceAmount: map['balanceAmount'],
      date: map['date'],
      invoiceNumber: map['invoiceNumber'],
      items: (map['items'] as List).map((item) => BillModel.fromMap(item)).toList(),
    );
  }
}
