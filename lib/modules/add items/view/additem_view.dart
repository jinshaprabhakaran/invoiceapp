
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:invoice/global/constants/styles/colors.dart';
import 'package:invoice/global/constants/widgets/buttons.dart';
import 'package:invoice/modules/invoice/controller/invoice_controller.dart';
import 'package:invoice/modules/add%20items/model/bills_model.dart';
import 'package:invoice/modules/add%20items/widgets/additems_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/widgets/text_field.widget.dart';

class AdditemViewScreen extends StatefulWidget {
  const AdditemViewScreen({super.key});

  @override
  State<AdditemViewScreen> createState() => _AdditemViewScreenState();
}

class _AdditemViewScreenState extends State<AdditemViewScreen> {
  List<BillModel> itemsList = []; 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: kBackground.withOpacity(0.9),
      appBar: AppBar(
        actions: [const Icon(Icons.settings, color: kGreen), Gap(10.h)],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: kBlack),
        ),
        backgroundColor: kWhite,
        title: KStyles().semiBold16(text: 'Add Items to Sale'),
      ),
      body: Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
              Container(
                color: kWhite,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                child: Column(
                  children: [
                    const Divider(height: 0.5, thickness: 2),
                    Gap(20.h),
                    TextFieldWidget(onChanged: (value){
                      setState(() {
                        
                      });
                      
                    },
                      textEditingController: invoCtrl.itemName,
                      hintText: 'Item Name',
                      labelText: 'Item Name',
                      textAlign: TextAlign.left,
                      boxHeight: 50,
                      boxWidth: double.infinity,
                      readOnly: false,
                      textColor: kBlack,
                    ),
                    Gap(10.h),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFieldWidget(
                            onChanged: (value){
                           
                               invoCtrl.subTotal(invoCtrl);
                               invoCtrl.calculateTotals(invoCtrl);
                            
                            
                          },
                            textEditingController: invoCtrl.quantity,
                            hintText: 'Quantity',
                              labelText: 'Quantitye',
                            textAlign: TextAlign.left,
                            boxHeight: 50,
                            readOnly: false,
                            textColor: kBlack,
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 50,
                            child: AdditemsDropdown(
                              items: invoCtrl.units,
                              selectedItem: invoCtrl.unit.isNotEmpty ? invoCtrl.unit : invoCtrl.units[0],
                              onChanged: (String? newValue) {
                                setState(() {
                                  invoCtrl.unit = newValue!;
                                });
                              },
                              hint: 'Unit',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFieldWidget(onChanged: (value){
                           
                               invoCtrl.subTotal(invoCtrl);
                                invoCtrl.calculateTotals(invoCtrl);
                            
                            
                          },
                            textEditingController: invoCtrl.rate,
                            hintText: 'Rate',
                              labelText: 'Rate',
                            textAlign: TextAlign.left,
                            boxHeight: 50,
                            boxWidth: double.infinity,
                            readOnly: false,
                            textColor: kBlack,
                          ),
                        ),
                        Gap(10.w),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 50,
                            child: AdditemsDropdown(
                              items: invoCtrl.taxes,
                              selectedItem: invoCtrl.tax.isNotEmpty ? invoCtrl.tax : invoCtrl.taxes[0],
                              onChanged: (String? newValue) {
                                setState(() {
                                  invoCtrl.tax = newValue!;
                                 
                                });
                              },
                              hint: 'Tax',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
              Gap(10.h),
              invoCtrl.itemName.text.isNotEmpty ?
              Container(
                color: kWhite,
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KStyles().semiBold14(text: 'Totals & Taxes'),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KStyles().med14(text: 'Subtotal (Rate * Qty)', color: kGrey),
                        KStyles().med14(text: invoCtrl.subtotal.toStringAsFixed(2), color: kGrey),
                      ],
                    ),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KStyles().med14(text: 'Discount', color: kGrey),
                        Gap(10.w),
                        SizedBox(
            height: 40,
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(10),
              isSelected: invoCtrl.isSelected,
               
              selectedBorderColor: Colors.amber,
              fillColor: Colors.amber.shade100, 
             
              onPressed: (int index) {
                setState(() {
                 
                  for (int i = 0; i < invoCtrl.isSelected.length; i++) {
                    invoCtrl.isSelected[i] = i == index; 
                  }
                  
                });
              },
              children: [
                KStyles().med14(text: '    0   '),
                KStyles().med14(text: '    %    '),
              ],
            ),
          ),
                        Gap(5.w),
                         Expanded(flex: 1,
                        child: TextFieldWidget(onChanged: (value){
                           
                                invoCtrl.calculateTotals(invoCtrl);
                            
                            
                          },
                          hintText: '0.0', readOnly: false, boxHeight: 50, textAlign: TextAlign.left, textColor: kBlack, textEditingController: invoCtrl.discountCtrl))
                      ],
                    ),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KStyles().med14(text: 'Tax %', color: kGrey),
                        Gap(10.w),
                         Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 50,
                            child: AdditemsDropdown(
                              items: invoCtrl.taxesTypes,
                              selectedItem: invoCtrl.selectedTax.isNotEmpty ? invoCtrl.selectedTax : invoCtrl.taxesTypes[0],
                              onChanged: 
                              (String? newValue) {
                                setState(() {
                                  invoCtrl.selectedTax = newValue!;
                                
                                });
                              },
                              hint: 'Tax',
                            ),
                          ),
                        ),
                          Gap(5.w),
                       
                       Expanded(flex: 1,
                        child: TextFieldWidget(onChanged: (value){                           
                                invoCtrl.calculateTotals(invoCtrl);
                          },
                          hintText: '0.0', readOnly: false, boxHeight: 50, textAlign: TextAlign.left, textColor: kBlack, textEditingController: invoCtrl.taxCtrl))
                      ],
                    ),
                    Gap(10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 1,
                          child: KStyles().med14(text: 'Additional CESS', color: kGrey)),
                        Gap(10.w),
                         Expanded(flex: 1,child: TextField(controller: invoCtrl.additional,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                                invoCtrl.calculateTotals(invoCtrl);
                          },
                          decoration: const InputDecoration(
                            hintText: '0.00',
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                        ),)
                      ],
                    ),
                   Gap(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        KStyles().semiBold14(text: 'Total Amount : '),
                        KStyles().semiBold14(text: invoCtrl.totalAmount.toStringAsFixed(2)),
                      ],
                    ),
                  ],
                ),
              ) : const SizedBox(),
            ],
          ),
        );
      }),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
floatingActionButton: Consumer<InvoiceController>(
  builder: (context, invoCtrl, child) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: CommonButton(
              backgroundColor: kWhite,     
            onPressed: () {
              invoCtrl.saveItem();
            },
          text: 'Save and New', textColor: kGrey)),   
        Expanded(
          flex: 1,
          child:  CommonButton(
              backgroundColor: Colors.red,
            onPressed: () {
              invoCtrl.saveItem();
              Navigator.pop(context);
            },
           text: 'Save', textColor: kWhite), 
        ),
      ],
    );
  },
));  
  }
}