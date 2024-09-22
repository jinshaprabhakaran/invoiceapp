import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../modules/home/controller/home_controller.dart';
import '../../../modules/invoice/controller/invoice_controller.dart';

List<SingleChildWidget>providersList = [
   ChangeNotifierProvider(create: (_) => InvoiceController()),
     ChangeNotifierProvider(create: (_) => HomeController())
];
