
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:invoice/modules/add%20items/model/bills_model.dart';
import 'package:provider/provider.dart';

import '../../home/controller/home_controller.dart';
import '../model/invoicemodel.dart';

class InvoiceController extends ChangeNotifier{
  // controllers
  TextEditingController customerName = TextEditingController();
  TextEditingController billName = TextEditingController();
  TextEditingController phoneNum = TextEditingController();
  TextEditingController itemName = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController rate = TextEditingController();
  TextEditingController taxCtrl = TextEditingController();
  TextEditingController discountCtrl = TextEditingController();
  TextEditingController additional = TextEditingController();
  TextEditingController dueCtrl = TextEditingController();

  // dropdown, toggle,checkbox

 List<bool> isSelected = [true, false];
 List<BillModel> itemsList = []; 
 bool isReceived = false;
 List<bool> isMoneySelected = [true, false];
  String selectedInvoiceDay ='23-24-01 16';
  String firmName ='xianinfotech LLP';
  String unit = '';
  String tax = '';
  String selectedTax = '';
    List<String> invoiceNumbers = ['23-24-01 16', '23-24-02 17', '23-24-03 18'];
    List<String> firmNames = ['xianinfotech LLP','TCS','Wipro'];
   List<String> units = ['gram','kilogram','liter'];
     List<String> taxes = ['Without tax','with tax'];
       List<String> taxesTypes = ['None','GST','use-tax'];

       //image,document,notes
File? image;
  File? document;
  String? note;

   DateTime selectedDate = DateTime.now();
  
  String get formattedDate {
    return DateFormat('dd/MM/yyyy').format(selectedDate);
  }

 pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      notifyListeners();
    }
  }

  
 pickDocument() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      document = File(result.files.single.path!);
      notifyListeners();
    }
  }

// calculating values for one item
  double subtotal = 0.0; 
  double additionalCess = 0.0; 
  double totalAmount = 0.0;
  double disValue = 0.0;


  subTotal(InvoiceController invoCtrl){
      int quantity = int.tryParse(invoCtrl.quantity.text) ?? 0;
    double rate = double.tryParse(invoCtrl.rate.text) ?? 0.0;
    subtotal = quantity * rate;
    notifyListeners();

  }
  double balance = 0.0;
  calculateBalanceAmount() {
    
    double dueAmount = double.tryParse(dueCtrl.text) ?? 0.0;

    
    balance = totalItemAmount - dueAmount;

    notifyListeners();
  }


   calculateTotals(InvoiceController invoCtrl) {
      double discountValue = double.tryParse(invoCtrl.discountCtrl.text)?? 0.0;
       double discount = isSelected[0] ? discountValue : (subtotal * (discountValue / 100));
        double discountedSubtotal = subtotal - discount;

       double taxVal = double.tryParse(invoCtrl.taxCtrl.text) ?? 0.0;
       double additionalVal = double.tryParse(invoCtrl.additional.text) ?? 0.0;
       double taxValueCalculated = (discountedSubtotal * (taxVal / 100));
      totalAmount = discountedSubtotal + taxValueCalculated + additionalVal;
     notifyListeners();
  }

 
// clearing
   clearFields() {
  itemName.text = '';
  quantity.text = '';
  rate.text = '';
  unit = '';
  taxCtrl.text = '';
  discountCtrl.text = '';
  isSelected = [true,false];
  additional.text = '';


  }

// calculating for different items
int totalQuantity = 0;
double totalDiscount = 0.0;
double totalSubtotal = 0.0;
double totalTax = 0.0;
double totalItemAmount = 0.0;

calculateTotal() {
  totalQuantity = 0; 
  totalDiscount = 0.0; 
  totalSubtotal = 0.0; 
  totalTax = 0.0; 
  totalItemAmount = 0.0;

  for (int i = 0; i < itemsList.length; i++) {
   
    totalQuantity += itemsList[i].quantity;
    totalItemAmount += itemsList[i].total;

   
    double itemDiscount;
    if (isSelected[0]) {
    
      itemDiscount = itemsList[i].discount;
    } else {
    
      itemDiscount = itemsList[i].subtotal * (itemsList[i].discount / 100);
    }
    
  
    double discountedSubtotal = itemsList[i].subtotal - itemDiscount;

    
    double itemTax = discountedSubtotal * (itemsList[i].tax / 100);
    totalDiscount += itemDiscount;
    totalSubtotal += discountedSubtotal;
    totalTax += itemTax;
  }

  notifyListeners(); 
}

// saving item
saveItem(){

  if(itemName.text.isNotEmpty && quantity.text.isNotEmpty && rate.text.isNotEmpty){
  BillModel newItem = BillModel(
    total: totalAmount,
      itemName: itemName.text,
      quantity: int.tryParse(quantity.text) ?? 0,
      rate: double.tryParse(rate.text) ?? 0.0,
     subtotal: subtotal,
      tax: taxCtrl.text.isNotEmpty ?
       double.parse(taxCtrl.text) : 0.0 ,
      discount: discountCtrl.text.isNotEmpty ?
      double.parse(discountCtrl.text) : 0.0
      
    );
    itemsList.add(newItem);
    calculateTotal();
    balance = totalItemAmount;
    clearFields();
  }else{

  }
    notifyListeners();
}

// saving invoice

 saveInvoice(BuildContext context) async {
   final homeCtrl = Provider.of<HomeController>(context, listen: false);
  InvoiceModel invoice = InvoiceModel(
    customerName: customerName.text,
    totalAmount: totalItemAmount,
    balanceAmount:balance,
    date: formattedDate,
    invoiceNumber: selectedInvoiceDay,
    items: itemsList,
  );

if(customerName.text.isNotEmpty && itemsList.isNotEmpty){
  await FirebaseFirestore.instance.collection('customers').add(invoice.toMap());
  homeCtrl.getInvoices();
  customerName.clear();
  billName.text = '';
  phoneNum.text = '';
selectedDate = DateTime.now();
 selectedInvoiceDay ='23-24-01 16';
firmName ='xianinfotech LLP';
  totalAmount = 0.0;
  balance = 0.0;
  dueCtrl.text = '';
 itemsList.clear();

 notifyListeners();
} 

}

    
}