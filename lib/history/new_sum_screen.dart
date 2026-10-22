import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynet_app/history/request_check_page.dart';
import 'package:paynet_app/widgets/number_format.dart';

import '../color/colors.dart';

class NewSumScreen extends StatefulWidget {
  const NewSumScreen({
    super.key,
    required this.amount,
    required this.name,
    required this.phone, required this.image, required this.card,
  });

  final String amount;
  final String name;
  final String phone;
  final File? image;
  final Map<String, String> card;

  @override
  State<NewSumScreen> createState() => _NewSumScreenState();
}

class _NewSumScreenState extends State<NewSumScreen> {
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xff055a41), Color(0xff000000), Color(0xff000000)],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RequestCheckPage(
                              name: widget.name,
                              amount: widget.amount,
                              phone: widget.phone, card: widget.card, image: widget.image,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 25.w),
                    Text(
                      'Изменить сумму',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'bold',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 380.w,
                  height: 120.h,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IntrinsicWidth(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              NumberFormatter(),
                              MaxValueInputFormatter(maxValue: 100000000)
                            ],
                            autofocus: false,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 36.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'medium',
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '${widget.amount}',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'medium'
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Padding(padding: EdgeInsets.only(bottom: 1.h),
                        child: Text('сум', style: TextStyle(color: Colors.grey),),
                        )
                      ],
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 380.w,
                  height: 56.h,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [trueColor, trueColor2]),
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RequestCheckPage(
                              name: widget.name,
                              amount: _amountController.text,
                              phone: widget.phone, card: widget.card, image: widget.image,
                            ),
                          ),
                        );
                      },
                      child: Center(
                        child: Text(
                          'Сохранить',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
