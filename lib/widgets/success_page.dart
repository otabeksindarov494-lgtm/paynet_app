import 'dart:io';
import 'package:flutter/material.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/history/request_check_page.dart';
import 'package:paynet_app/widgets/true_request_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessPage extends StatelessWidget {
  final String amount;
  final String name;
  final String phone;
  final File? image;
  final Map<String, String> card;

  const SuccessPage({
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
                    'Запрос на $amount сум успешно отправлен ползователю $name',
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
                        height: 60.h,
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
                              Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
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
                        height: 60.h,
                        child: TrueRequestButton(
                          label: 'Посмотреть детали запроса',
                          height: 56.h,
                          borderRadius: 32.r,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RequestCheckPage(
                                  name: name,
                                  amount: amount,
                                  phone: phone,
                                  card: card,
                                  image: image,
                                ),
                              ),
                            );
                          },
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
