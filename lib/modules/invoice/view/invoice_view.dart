import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:invoice/global/constants/widgets/buttons.dart';

import 'package:invoice/modules/invoice/controller/invoice_controller.dart';
import 'package:invoice/modules/invoice/widgets/balance_amount_section.dart';
import 'package:invoice/modules/invoice/widgets/description_section.dart';

import 'package:invoice/modules/invoice/widgets/invoice_section.dart';
import 'package:invoice/modules/invoice/widgets/payment_section.dart';

import 'package:invoice/modules/invoice/widgets/textfield_section.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/styles/colors.dart';



class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {

  

  @override
  Widget build(BuildContext context) {
    return  Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
   return Scaffold(resizeToAvoidBottomInset: false,
      backgroundColor: kBackground.withOpacity(0.9),
      appBar: AppBar(
        leadingWidth: 50,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: kBlack),
        ),
        backgroundColor: kWhite,
        actions: [
          SizedBox(
            height: 40,
            child: ToggleButtons(
              borderRadius: BorderRadius.circular(30),
              isSelected:invoCtrl.isMoneySelected,
              selectedColor: kGrey,
              fillColor: kGreen,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < invoCtrl.isMoneySelected.length; i++) {
                   invoCtrl.isMoneySelected[i] = i == index; 
                  }
                });
              },
              children: [
                KStyles().med14(text: '  Credit  '),
                KStyles().med14(text: '  Cash  '),
              ],
            ),
          ),
          const Gap(60),
          const Icon(Icons.settings, color: Colors.green),
          const Gap(10),
        ],
        title: KStyles().semiBold17(text: 'Sale'),
      ),
     body: Column(
    children: [
      const Divider(height: 0.5, thickness: 5),
      InvoiceSection(onInvoiceChanged: (value){setState(() {
                    invoCtrl.selectedInvoiceDay = value!;
                  });
            }, onFirmNameChanged:  (String? newValue) {
                  setState(() {
                    invoCtrl.firmName = newValue!;
                  });
                }, onPressed: ()async{
                     DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: invoCtrl.selectedDate,
                  firstDate: DateTime(2000), 
                  lastDate: DateTime(2101),
                                  );
                                  if (pickedDate != null) {
                  setState(() {
                    invoCtrl.selectedDate = pickedDate; 
                  });
                                  }
                                
                  }),
      Gap(10.h),
      Expanded(
        child: SingleChildScrollView(physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const  TextFieldSection(),
             Gap(10.h),
          
          invoCtrl.itemsList.isNotEmpty ?BalanceAmountSection(onBalanceChanged: (value){
 setState(() {
                invoCtrl.isReceived = value!;
              
                if (invoCtrl.isReceived) {
                  invoCtrl.dueCtrl.text = invoCtrl.totalItemAmount.toStringAsFixed(2); 
                } else {
                  invoCtrl.dueCtrl.text = '0.0'; 
                }
                invoCtrl.calculateBalanceAmount(); 
              });
          }) : const SizedBox(),
             Gap(10.h),
               invoCtrl.itemsList.isNotEmpty ? PaymentSection(onPaymentChanged: (value){
                 setState(() {
                    invoCtrl.isMoneySelected[0] = value == 'Credit';
                    invoCtrl.isMoneySelected[1] = value == 'Cash';
                  });
               },onStateChanged: (value){
                setState(() {
                  invoCtrl.selectedState = value.toString();
                });
               },) : const SizedBox(),
              Gap(10.h),
             invoCtrl.itemsList.isNotEmpty ? const DescriptionSection(): const SizedBox(),
            ],
          ),
        ),
      ),
        
         
    
    ]),floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
floatingActionButton:Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
        return  Row(
              children: [
                    Expanded(flex: 1,
                      child: 
                     CommonButton(onPressed: (){
                      invoCtrl.saveInvoice(context);
                     }, backgroundColor: kWhite, textColor: kGrey, text: 'Save & new')
                    ),
                    Expanded(flex: 1,
                      child: CommonButton(onPressed: (){
                      invoCtrl.saveInvoice(context);
                      Navigator.pushNamed(context, '/');
                     }, backgroundColor: kBlue, textColor: kWhite, text: 'Save')
                    ),
                     Expanded(flex: 1,
                      child: ElevatedButton(style:
                       ElevatedButton.styleFrom(backgroundColor:kWhite,shape: const RoundedRectangleBorder()),
                        onPressed: () { 
                        },
                        child: const Icon(Icons.send_rounded,color: kBlue,),
                      ),
                    ),
                    ]);

  }));
  }
    );
  }


 
}