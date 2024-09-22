import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice/modules/invoice/widgets/item_section.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/widgets/text_field.widget.dart';
import '../controller/invoice_controller.dart';

class TextFieldSection extends StatelessWidget {
  const TextFieldSection({super.key});

  @override
  Widget build(BuildContext context) {
     return Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          TextFieldWidget(
            textEditingController: invoCtrl.customerName,
            hintText: 'Customer Name',
            labelText: 'Customer Name',
            boxHeight: 60,
            boxWidth: double.infinity,
            textColor: Colors.black, readOnly: false,textAlign: TextAlign.left,
          ),
          SizedBox(height: 5.h),
          TextFieldWidget(readOnly: false,textAlign: TextAlign.left,
            textEditingController: invoCtrl.billName,
            labelText: 'Billing Name',
            hintText: 'Billing Name (Optional)',
            boxHeight: 50,
            boxWidth: double.infinity,
            textColor: Colors.black,
          ),
          SizedBox(height: 5.h),
          TextFieldWidget(readOnly: false,textAlign: TextAlign.left,
            textEditingController: invoCtrl.phoneNum,
            hintText: 'Phone Number',
            labelText: 'Phone',
            boxHeight: 50,
            boxWidth: double.infinity,
            textColor: Colors.black,
          ),
        const  ItemSection()
        ],
      ),
    );

  });
  }
}