import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:invoice/global/constants/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InvoiceContainer extends StatelessWidget {
  const InvoiceContainer({super.key,required this.customerName,required this.invoiceNum,required this.date,required this.total,required this.onPressed
  ,required this.balance});
final String customerName;
final String invoiceNum;
final String date;
final String total;
final String balance;
final Function()onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 10.h),
      child: Container(width: double.infinity,padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: kWhite),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KStyles().semiBold15(text: customerName,color: kBlack.withOpacity(0.5)),
              Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               
                KStyles().med14(text: invoiceNum,color: kGrey),
                KStyles().med14(text: date,color: kGrey)
              ],)
            ],
          ),
         
          Container(padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: const Color.fromARGB(255, 128, 238, 207)),
          child: KStyles().med14(text: 'SALE',color: kGreen),),
          Gap(10.h),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KStyles().semiBold14(text: 'Total',color: kGrey),
                KStyles().semiBold17(text: total,color: kBlack),
      
              ],
            ),
             Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KStyles().semiBold14(text: 'Balance',color: kGrey),
                KStyles().semiBold17(text: balance,color: kBlack),
      
              ],
            ),
            IconButton(onPressed: onPressed, icon: const Icon(Icons.print),color: kBlack.withOpacity(0.2),),
         
           Icon(Icons.send,color:  kBlack.withOpacity(0.2),),
           Icon(Icons.menu,color: kBlack.withOpacity(0.2))
          ],)
        ],
      ),),
    );
  }
}
 