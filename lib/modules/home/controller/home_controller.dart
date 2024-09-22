import 'dart:developer';
import 'package:pdf/widgets.dart' as pw; 
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice/modules/home/view/home_screen.view.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import '../../invoice/model/invoicemodel.dart';

class HomeController extends ChangeNotifier {

  TextEditingController searchCtrl = TextEditingController();

  List screens = [
    const HomeScreen(),
   const HomeScreen(),
   const HomeScreen(),
   const HomeScreen(),
   const HomeScreen(),
  ];

   List<InvoiceModel> filteredInvoices = [];

  filterInvoices(String query) {
    final lowerCaseQuery = query.toLowerCase();
    if (lowerCaseQuery.isEmpty) {
      filteredInvoices = invoices; 
    } else {
      filteredInvoices = invoices.where((invoice) {
        return invoice.customerName.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    }
    notifyListeners();
  }
// selecting the index(bottom navigation)
  int selectedIndex = 0;
setIndex(int index){
selectedIndex = index;
notifyListeners();
}

// converting date
String convertDate(String dateInput) {
  DateTime parsedDate = DateFormat('dd/MM/yyyy').parse(dateInput);
  String formattedDate = DateFormat('dd, MMM yyyy').format(parsedDate);

  return formattedDate;
}

  

List<InvoiceModel> invoices = [];

// get invoices list
 getInvoices() async {
  try {
     QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('customers')
        .get();
    
    invoices.clear();

    invoices = querySnapshot.docs.map((doc) {
      return InvoiceModel.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
    filteredInvoices = invoices;
    log('Fetched ${invoices.length} invoices successfully');
    notifyListeners();
  } catch (e) {
    log('Failed to fetch invoices: $e');
    notifyListeners();
  }
}
//init function
onInit() {   
  getInvoices();
   
}

// function to get pdf
printInvoice(BuildContext context, InvoiceModel invoice) async {
  final pdf = pw.Document();

  // Define the PDF structure
  pdf.addPage(
    pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Company and Invoice Details
            pw.Text('Invoice', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 20),
            pw.Text('Customer: ${invoice.customerName}'),
            pw.Text('Invoice Number: ${invoice.invoiceNumber}'),
            pw.Text('Date: ${invoice.date}'),
            pw.SizedBox(height: 20),
            
            // Items Table Header
            pw.TableHelper.fromTextArray(
              headers: ['Item Name', 'Quantity', 'Rate', 'Subtotal'],
              data: invoice.items.map((item) => [
                item.itemName,
                item.quantity.toString(),
                item.rate.toString(),
                item.subtotal.toString()
              ]).toList(),
            ),
            
            pw.SizedBox(height: 20),

            // Totals Section
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Subtotal', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(invoice.items.fold<double>(0, (sum, item) => sum + item.subtotal).toStringAsFixed(1)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total Discount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(invoice.items.fold<double>(0, (sum, item) => sum + item.discount).toStringAsFixed(2)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total Tax', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(invoice.items.fold<double>(0, (sum, item) => sum + item.tax).toStringAsFixed(2)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Total Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(invoice.totalAmount.toStringAsFixed(2)),
              ],
            ),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Balance Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text(invoice.balanceAmount.toStringAsFixed(2)),
              ],
            ),
          ],
        );
      },
    ),
  );
  await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}

}