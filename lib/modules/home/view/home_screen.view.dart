import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:invoice/global/constants/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice/global/constants/widgets/text_field.widget.dart';

import 'package:invoice/modules/home/controller/home_controller.dart';
import 'package:invoice/modules/home/widget/home_icons.widget.dart';
import 'package:invoice/modules/home/widget/invoice_container.widget.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double keyboardHeight = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).onInit();
    });
  }

  @override
  Widget build(BuildContext context) {
     keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return DefaultTabController(
      length: 2,
      child: Scaffold(resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 235, 245, 235),
        appBar: AppBar(
          backgroundColor: kWhite,
          leadingWidth: 50,
          leading: const Icon(Icons.home, color: kBlue),
          title: KStyles().semiBold18(text: 'xianinfotech LLP'),
          actions: [
            const Icon(Icons.notifications_none, color: kGrey),
            Gap(5.w),
            const Icon(Icons.settings, color: kGreen),
            Gap(10.w),
          ],
          bottom: TabBar(
            labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            indicator: BoxDecoration(
              border: Border.all(color: kRed),
              color: kRed.shade100,
              borderRadius: BorderRadius.circular(30),
            ),
            unselectedLabelColor: kGrey,
            dividerColor: kGrey.shade100,
            automaticIndicatorColorAdjustment: false,
            padding: const EdgeInsets.only(bottom: 20, top: 5),
            labelColor: kRed,
            overlayColor: WidgetStatePropertyAll(kRed.shade100),
            tabs: const [
              Tab(text: '  Transaction Details  '),
              Tab(text: ' Party Details '),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Consumer<HomeController>(
                builder: (context, homCtrl, child) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: const BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HomeIcons(icon: Icon(Icons.add, color: kBlack), color: kRed, text: 'Add Txn'),
                            HomeIcons(icon: const Icon(Icons.book, color: kBlack), color: kBlue.shade200, text: 'Sale Report'),
                            HomeIcons(icon: const Icon(Icons.settings, color: kBlack), color: kBlue.shade200, text: 'Txn Setting'),
                            HomeIcons(icon: const Icon(Icons.arrow_circle_right, color: kBlack), color: kBlue.shade200, text: 'Show All'),
                          ],
                        ),
                      ),
                      Gap(10.h),
                      TextFieldWidget(
                        onChanged: (value) {
                          homCtrl.filterInvoices(value);
                        },
                        prefix: const Icon(Icons.search, color: kBlue),
                        suffixIcon: const Icon(Icons.filter_list, color: kGrey),
                        hintText: 'Search for a transaction',
                        readOnly: false,
                        boxHeight: 40,
                        textAlign: TextAlign.left,
                        textColor: kBlack,
                        textEditingController: homCtrl.searchCtrl,
                      ),
                      Gap(10.h),
                      Expanded(  
                        child: ListView.builder(
                          itemCount: homCtrl.filteredInvoices.length,
                          shrinkWrap: true,
                         physics:const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final invoice = homCtrl.filteredInvoices[index];
                            return InvoiceContainer(
                              onPressed: () {
                                homCtrl.printInvoice(context, invoice);
                              },
                              customerName: invoice.customerName,
                              date: homCtrl.convertDate(invoice.date),
                              invoiceNum: invoice.invoiceNumber,
                              total: invoice.totalAmount.toString(),
                              balance: invoice.balanceAmount.toStringAsFixed(1),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Column(),  
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:
         Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: kRed),
            onPressed: () {
              Navigator.pushNamed(context, 'invoice');
            },
            child: KStyles().med14(text: 'Add New Sale', color: kWhite),
          ),
        ),
      ),
    );
  }
}
