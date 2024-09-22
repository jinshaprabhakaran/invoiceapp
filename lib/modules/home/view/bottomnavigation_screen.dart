

import 'package:flutter/material.dart';
import 'package:appdebug_font_package/appdebug_font_package.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invoice/global/constants/styles/colors.dart';
import 'package:invoice/modules/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HomeController>(context, listen: false).onInit();
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeCtrl, child) {
        return Scaffold(
          backgroundColor: KColors().kWhite,
          body: homeCtrl.screens[homeCtrl.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: homeCtrl.selectedIndex,
            onTap: (value) {
             homeCtrl.setIndex(value);
            },
       backgroundColor: kWhite,
            selectedItemColor: kBlue,
            unselectedItemColor: kBlack.withOpacity(0.8),
            selectedFontSize: 13,
            unselectedFontSize: 13,
           
            items: [
               BottomNavigationBarItem(
                label: 'Home',
                icon: Icon(Icons.home,size: 20.sp,),
              ),
              BottomNavigationBarItem(
                label: 'Dashboard',
                icon: Icon(Icons.bar_chart, size: 20.sp),
              ),
              BottomNavigationBarItem(
                label: 'items',
                icon: Icon(Icons.add, size: 20.sp),
              ),
              BottomNavigationBarItem(
                label: 'Menu',
                icon: Icon(Icons.menu, size: 20.sp),
              ),
              BottomNavigationBarItem(
                label: 'Get Premium',
                icon: Icon(Icons.collections, size: 20.sp),
              ),
            ],
          ),
        );
      },
    );
  }
}
