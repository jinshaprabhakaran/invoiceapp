import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/styles/colors.dart';
import '../../add items/widgets/items_list.widget.dart';
import '../controller/invoice_controller.dart';

class ItemSection extends StatelessWidget {
  const ItemSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
    return   Container(
      color: kWhite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          invoCtrl.itemsList.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(color: kBlue, borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: KStyles().med14(text: 'Bill Items', color: Colors.white),
                  ),
                )
              : const SizedBox(),
          Gap(10.h),
          ListView.builder(
            itemCount: invoCtrl.itemsList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ItemContainer(
                itemName: invoCtrl.itemsList[index].itemName,
                total: invoCtrl.itemsList[index].total.toString(),
                discount: invoCtrl.itemsList[index].discount.toString(),
                subtotal: invoCtrl.itemsList[index].subtotal.toString(),
                quantity: invoCtrl.itemsList[index].quantity.toString(),
                rate: invoCtrl.itemsList[index].rate.toString(),
                tax: invoCtrl.itemsList[index].tax.toString(),
              );
            },
          ),
        invoCtrl.itemsList.isNotEmpty ?
          Column(
            children: [
              Gap(10.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Expanded(flex: 1,
                child: KStyles().med14(text: 'Total Disc : ${invoCtrl.totalDiscount.toStringAsFixed(2)}',color: kGrey)),
              
                Expanded(flex: 1,
                  child: KStyles().med14(text: 'Total Tax Amt : ${invoCtrl.totalTax.toStringAsFixed(2)}',color: kGrey)),

                ],
              ),
              Gap(5.h),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               Expanded(flex: 1,
                child: KStyles().med14(text: 'Total Qty : ${invoCtrl.totalQuantity}',color: kGrey)),
                
                Expanded(flex: 1,
                  child: KStyles().med14(text: 'Subtotal : ${invoCtrl.totalSubtotal.toStringAsFixed(1)}',color: kGrey)),

                ],
              ),
               Gap(10.h),
            ],
          ) : const SizedBox(),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'additems');
            },
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: kWhite,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              child: FloatingActionButton(
                mini: true,
                shape: const CircleBorder(),
                elevation: 0,
                onPressed: () {
                  Navigator.pushNamed(context, 'additems');
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ),
            Gap(2.w),
            KStyles().semiBold13(text: 'Add Items', color: Colors.blue),
            Gap(2.w),
            KStyles().semiBold13(text: '(Optional)', color: Colors.grey),
          ],
        ),
      ),
    )),
          Gap(15.h),
          invoCtrl.itemsList.isEmpty ? KStyles().med15(text: 'Total Amount                        -------------') : const SizedBox()
        ],
      ),
    );
  }
    );
  }
  }
