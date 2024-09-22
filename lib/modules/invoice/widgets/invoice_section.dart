import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/styles/colors.dart';
import '../../../global/constants/widgets/dropdown_widget.dart';
import '../controller/invoice_controller.dart';

class InvoiceSection extends StatelessWidget {
  const InvoiceSection({super.key, required this.onInvoiceChanged,
    required this.onFirmNameChanged,required this.onPressed});
  final ValueChanged<String?> onInvoiceChanged;
  final ValueChanged<String?> onFirmNameChanged;
  final Function()onPressed;
  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
   return  Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        KStyles().semiBold17(text: 'Invoice No', color: kGrey),
              CommonDropdown(
              items: invoCtrl.invoiceNumbers,
                selectedItem: invoCtrl.selectedInvoiceDay,
                onChanged: onInvoiceChanged,
              ),]),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            
                    KStyles().semiBold17(text: 'Date', color: kGrey),
                  IconButton(onPressed: onPressed, icon:  Row(
                    children: [
                      KStyles().bold15(text: invoCtrl.formattedDate),
                      Gap(5.w),
                      const Icon(Icons.arrow_drop_down,color: kGrey,),
                    ],
                  )),
                ],
              ),
            ],
          ),
          Divider(color: Colors.grey.withOpacity(0.3), height: 0.4),
          Row(
            children: [
              KStyles().med14(text: 'Firm Name :   ', color: Colors.grey),
              CommonDropdown(
                items: invoCtrl.firmNames,
                selectedItem: invoCtrl.firmName.isNotEmpty ? invoCtrl.firmName : invoCtrl.firmNames[0],
                onChanged: onFirmNameChanged,
              ),
            ],
          ),
        ],
      ),
        );
  });
  }
  }
