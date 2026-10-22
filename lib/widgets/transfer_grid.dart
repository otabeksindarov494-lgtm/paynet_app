import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_glow_border/gradient_glow_border.dart';
import 'package:paynet_app/images/images.dart';
import 'package:paynet_app/widgets/request_money_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color/colors.dart';
import 'bottom_sheet_border.dart';

class TransferGrid extends StatelessWidget {
  const TransferGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final contactUser = [
      {'name': 'Sindarov Otabek', 'phone': '+998 50 054 47 64'},
      {'name': 'Xolmatov Alisher', 'phone': '+998 50 054 47 64'},
      {'name': 'Sindarova Gozal', 'phone': '+998 50 054 47 64'},
      {'name': 'Ismoilov Abror', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Norchayeva Mamura', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Polatov Oyatulloh', 'phone': '+998 50 054 47 64'},
      {'name': 'Sindarov Otabek', 'phone': '+998 50 054 47 64'},
      {'name': 'Sindarov Otabek', 'phone': '+998 50 054 47 64'},
      {'name': 'Sindarov Otabek', 'phone': '+998 50 054 47 64'},
      {'name': 'Sindarov Otabek', 'phone': '+998 50 054 47 64'},
      {'name': 'Sindarov Otabek', 'phone': '+998 50 054 47 64'},
    ];

    void bottomSheet(BuildContext context) {
      showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: "",
        barrierColor: Colors.black.withOpacity(0.2),
        transitionDuration: const Duration(milliseconds: 250),
        pageBuilder: (context, animation, secondaryAnimation) {
          return Stack(
            children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.black.withOpacity(0.1)),
              ),
              Positioned.fill(
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(color: Colors.transparent),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  color: Colors.transparent,
                  child: BottomSheetBorder(
                    topRadius: 30.r,
                    fill: color1,
                    accent: trueColor2,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.85.h,
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          right: 20.w,
                          left: 20.w,
                          bottom: 20.h,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 40.w,
                                height: 4.h,
                                decoration: BoxDecoration(
                                  color: sheetColor,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                            ),

                            SizedBox(height: 10.h),

                            Text(
                              'Контакты',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontFamily: 'bold',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            SizedBox(
                              width: 380.w,
                              height: 60.h,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                decoration: BoxDecoration(
                                  border: GradientBoxBorder(
                                    gradient: LinearGradient(
                                      colors: [primaryColor, trueColor2],
                                    ),
                                  ),
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Имя или номер телефона',
                                          hintStyle: TextStyle(
                                            fontSize: 18.sp,
                                            fontFamily: 'regular',
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white54,
                                          ),
                                          icon: Image.asset(
                                            'assets/images/img_16.png',
                                            width: 18.w,
                                            height: 19.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.separated(
                                padding: EdgeInsets.only(top: 15.h),
                                shrinkWrap: true,
                                itemCount: contactUser.length,
                                itemBuilder: (context, index) {
                                  final contact = contactUser[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => RequestMoneyPage(
                                            name: contact['name']!,
                                            phone: contact['phone']!,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        top: 10.h,
                                        right: 15.w,
                                        left: 8.w,
                                        bottom: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF16191D),
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 22.r,
                                            backgroundColor: Colors.white12,
                                            child: Text(
                                              contact['name']![0],
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 14.w),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                contact['name']!,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white,
                                                  fontFamily: 'regular',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                contact['phone']!,
                                                style: TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Image.asset(
                                            'assets/images/img_19.png',
                                            width: 14.w,
                                            height: 14.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                      return Divider(
                                        height: 1.h,
                                        color: dividerColor,
                                        thickness: 2,
                                        indent: 60,
                                      );
                                    },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
    );
  }

    final items = [
      {'image': iconImage, 'title': 'На карту Paynet'},
      {'image': img4, 'title': 'На  свою карту'},
      {'image': img2, 'title': 'По реквизитам'},
      {'image': img3, 'title': 'Запрос денег'},
      {'image': atto, 'title': 'На карту ATTO'},
      {'image': visaCard, 'title': 'Visa Direct'},
    ];

    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15.h,
          crossAxisSpacing: 15.w,
          childAspectRatio: 1.7,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (items[index]['title'] == 'Запрос денег') {
                bottomSheet(context);
              }
            },
            child: Container(
              padding: EdgeInsets.all(16.r),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  items[index]['image'] as Widget,
                  SizedBox(height: 10.h),
                  Text(
                    items[index]['title'] as String,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontFamily: 'regular',
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
