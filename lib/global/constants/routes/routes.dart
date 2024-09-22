import 'package:flutter/material.dart';
import 'package:invoice/modules/home/view/bottomnavigation_screen.dart';
import 'package:invoice/modules/invoice/view/invoice_view.dart';

import '../../../modules/add items/view/additem_view.dart';

Map<String, Widget Function(BuildContext)> routes = {
  '/' :(BuildContext context) => const BottomNavigationScreen(),
    'invoice' : (BuildContext context) => const InvoiceScreen(),
    'additems' : (BuildContext context) => const AdditemViewScreen(),
    

};