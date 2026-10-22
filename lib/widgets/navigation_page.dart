import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/history/history_page.dart';
import 'package:paynet_app/pages/Transfer_page.dart';
import 'package:paynet_app/widgets/contact_page.dart';
import 'package:paynet_app/widgets/send_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key,});



  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  var currentIndex = 0;
  final List<Widget> pages = [
    TransferPage(),
    ContactPage(),
    SendPage(),
    HistoryPage(amount: '', name: '', phone: '', image: null, card: {}),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          IndexedStack(index: currentIndex, children: pages),
          Positioned(
            left: 0.w,
            right: 0.w,
            bottom: 0.h,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 85.h,
                  decoration: BoxDecoration(
                    color: Color(0xFF16191D).withOpacity(0.70),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      navItem(0, 'assets/images/img_7.png', 'Главная'),
                      navItem(1, 'assets/images/img_12.png', 'Переводы'),
                      navItem(2, 'assets/images/img_9.png', 'Оплата'),
                      navItem(3, 'assets/images/img_10.png', 'История'),
                      navItem(4, 'assets/images/img_11.png', 'Сервисы'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget navItem(int index, String image, String label) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 22.w,
              height: 22.h,
              color: isSelected ? trueColor2 : greyColor,
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: isSelected ? trueColor2 : greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
