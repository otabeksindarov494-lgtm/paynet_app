import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:paynet_app/history/history_page.dart';
import 'package:paynet_app/widgets/navigation_page.dart';

import '../color/colors.dart';
import '../widgets/true_request_button.dart';

class ResultPage extends StatelessWidget {
  final String amount;
  final String name;
  final String phone;
  final File? image;
  final Map<String, String> card;

  const ResultPage({
    super.key,
    required this.amount,
    required this.name,
    required this.phone,
    required this.image,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff055a41), Color(0xff000000), Color(0xff000000)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 144.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/img_20.png',
                    width: 120.w,
                    height: 120.h,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Запрос отправлен!',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'bold',
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    'Запрос на $amount сум успешно оплачен ползователю $name',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'regular',
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 380.w,
                        height: 56.h,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [trueColor, trueColor2],
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NavigationPage(),
                                ),
                              );
                            },
                            child: Text(
                              'Вернуться к переводам',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: 380.w,
                        height: 56.h,
                        child: Container(
                          decoration: BoxDecoration(
                            border: GradientBoxBorder(
                              gradient: LinearGradient(
                                colors: [primaryColor, trueColor2],
                              ),
                              width: 2.w,
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                            color: primaryColor,
                          ),
                          child: TrueRequestButton(
                            label: 'Посмотреть детали',
                            height: 56.h,
                            borderRadius: 30.r,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HistoryPage(
                                    amount: amount,
                                    name: name,
                                    phone: phone,
                                    image: image,
                                    card: card,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
