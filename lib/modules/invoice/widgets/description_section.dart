import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:invoice/modules/invoice/controller/invoice_controller.dart';
import 'package:provider/provider.dart';

import '../../../global/constants/styles/colors.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
      return Consumer<InvoiceController>(builder: (context, invoCtrl, child) {
    return Container(
    color: kWhite,
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      
        Row(
          children: [
            Expanded(
              flex: 4,
              child: TextField(
                maxLines: 3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: kGrey),
                  ),
                  hintText: 'Add Note',
                  labelText: 'Description',
                ),
                onChanged: (value) {
                  invoCtrl.note = value;
                },
              ),
            ),
           Gap(10.w),
         
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: () async {
                
                  await invoCtrl.pickImage();
                },
                child: invoCtrl.image == null
                    ? Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Icon(
                          Icons.add_photo_alternate,
                          color: kBlue,
                          size: 40.w,
                        ),
                      )
                    : Image.file(
                        invoCtrl.image!,
                        fit: BoxFit.cover,
                        width: 60.w,
                        height: 60.h,
                      ),
              ),
            ),
          ],
        ),
       Gap(15.h),
       
        InkWell(
          onTap: () async {
           
            await invoCtrl.pickDocument();
          },
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: kGrey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.insert_drive_file, color: kGrey),
               Gap(10.w),
                Text(
                  invoCtrl.document != null
                      ? 'Document Added'
                      : 'Add Document',
                  style: TextStyle(
                    color: kGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
       Gap(10.h),
       
        Center(
          child: KStyles().med14(text:
            'Internet is required to upload',color: kGrey
           
          ),
        ),
      ],
    ),
  );
  });
  }
}