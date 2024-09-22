import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/styles/colors.dart';
import '../controller/invoice_controller.dart';

class BalanceAmountSection extends StatelessWidget {
  const BalanceAmountSection({super.key,required this.onBalanceChanged});
final ValueChanged<bool?> onBalanceChanged;
  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
    return  Container(
    color: kGrey.shade200,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            KStyles().semiBold15(text: 'Total Amount'),
            KStyles().semiBold15(text: invoCtrl.totalItemAmount.toStringAsFixed(2)),
          ],
        ),
        Gap(10.h),
       
       Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: invoCtrl.isReceived,
            onChanged: onBalanceChanged
          ),
          KStyles().med15(text: 'Received'),
        ],
      ),
    ),
    Expanded(
      flex: 1,
      child: TextField(
        controller: invoCtrl.dueCtrl,
        onChanged: (value) {
          invoCtrl.calculateBalanceAmount(); 
        },
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          hintText: '0.00',
          contentPadding: EdgeInsets.all(8.0),
        ),
      ),
    )
  ],
),

Gap(10.h),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    KStyles().med17(text: 'Balance Due', color: Colors.teal),
    KStyles().med17(
      text: invoCtrl.balance.toStringAsFixed(2),
      color: Colors.teal,
    ),
  ],
),
      ],
    ),
  );
  });
  }
}