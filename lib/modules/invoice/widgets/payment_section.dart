import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/styles/colors.dart';
import '../../../global/constants/widgets/dropdown_widget.dart';
import '../controller/invoice_controller.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key,required this.onPaymentChanged,required this.onStateChanged});
   final ValueChanged<String?> onPaymentChanged;
     final ValueChanged<String?> onStateChanged;

  @override
  Widget build(BuildContext context) {
     return Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KStyles().semiBold15(text: 'Payment Type',color: kGrey),
              CommonDropdown(
                items: const ['Cash', 'Credit'],
                selectedItem: invoCtrl.isMoneySelected[0] ? 'Credit' : 'Cash',
                onChanged:onPaymentChanged,
              ),
            ],
          ),
          const Divider(color: kGrey,thickness: 0.3,),
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          KStyles().semiBold15(text: 'State of Supply',color: kGrey),
          CommonDropdown(
            items: invoCtrl.states,
            selectedItem: invoCtrl.selectedState,
            onChanged: onStateChanged,
          ),
        ],
      ),
      const Divider(color: kGrey,thickness: 0.3,),
      KStyles().semiBold14(text: 'Transpotation Details',color: kBlue),
      Gap(10.h),
      const Divider(color: kGrey,thickness: 0.3,height: 0.1,),
        ],
      ),
    );
  });
  }
}