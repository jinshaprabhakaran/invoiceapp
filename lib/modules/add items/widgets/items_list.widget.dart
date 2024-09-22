import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:invoice/global/constants/styles/colors.dart';


class ItemContainer extends StatelessWidget {
  const ItemContainer({super.key,required this.itemName,required this.total,required this.discount,required this.subtotal,required this.quantity,required this.rate,required this.tax});
final String itemName;
final String total;
final String quantity;
final String rate;
final String subtotal;
final String discount;
final String tax;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),    
      decoration: BoxDecoration(color: kGrey.shade200,borderRadius: BorderRadius.circular( 10)),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KStyles().semiBold15(text:itemName ),
              KStyles().semiBold15(text:total ),
            ],
          ),
         const Gap(10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          KStyles().semiBold15(text:'item Subtotal',color: kGrey),  
            KStyles().semiBold15(text:'$quantity * $rate = $subtotal',color: kGrey),  

          ],),
           const Gap(10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          KStyles().semiBold15(text:'Discount(%)',color: Colors.amber),  
            KStyles().semiBold15(text:discount,color: Colors.amber),  

          ],),
           const Gap(10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          KStyles().semiBold15(text:'Tax(%)',color: kGrey),  
            KStyles().semiBold15(text:tax,color: kGrey),  

          ],)

        ],
      ),
      
      ),
    );
  }
}