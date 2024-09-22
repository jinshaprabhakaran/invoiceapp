import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:invoice/global/constants/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeIcons extends StatelessWidget {
  const HomeIcons({super.key,required this.icon,required this.color,required this.text});
final Icon icon;
final Color color;
final String text;
  @override
  Widget build(BuildContext context) {
    return Stack(clipBehavior: Clip.none,
      children: [
        const SizedBox(height:70,width: 60,),
          Positioned(top:10,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width:40,height: 20,
                decoration: BoxDecoration(color: color,
                  borderRadius: BorderRadius.circular(2)),),
                  Gap(10.h),
                  KStyles().semiBold13(text: text,color: kBlack.withOpacity(0.6))
              ],
            ),
          ),
        
        Positioned(top: 0 ,left: 8,
          child:Center(child: icon,) )
      ],
    );
  }
}