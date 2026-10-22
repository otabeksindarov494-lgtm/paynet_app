import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/history/history_storage.dart';
import 'package:paynet_app/history/request_history.dart';
import 'package:paynet_app/pages/result_page.dart';

class PasswordPage extends StatefulWidget {
  final String name;
  final String amount;
  final String requestId;
  final String phone;
  final File? image;
  final Map<String, String> card;

  const PasswordPage({
    super.key,
    required this.name,
    required this.amount,
    required this.requestId,
    required this.phone,
    required this.image,
    required this.card,
  });

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController controller = TextEditingController();

  int second = 59;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      if (second == 0) {
        t.cancel();
      } else {
        setState(() {
          second--;
        });
      }
    });
  }

  void goToSuccess() {
    final index = requestHistory.indexWhere((e) => e.id == widget.requestId);
    if (index != -1) {
      requestHistory[index].status = 'Успешно';
      saveRequest();
    }
    if (controller.text.length == 5) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultPage(
            amount: widget.amount,
            name: widget.name,
            phone: widget.phone,
            image: widget.image,
            card: widget.card,
          ),
        ),
      );
    }
  }

  Widget buildBox(int index) {
    String text = '';
    if (index < controller.text.length) {
      text = controller.text[index];
    }

    return Container(
      width: 60.w,
      height: 55.h,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: primaryColor),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w700, fontFamily: 'bold')),
    );
  }

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
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60.h),

              Align(
                alignment: Alignment.centerLeft,
                child: Icon(Icons.arrow_back, color: Colors.white),
              ),

              SizedBox(height: 40.h),
              Text(
                'Введите код',
                style: TextStyle(
                  fontSize: 24.sp,
                  color: Colors.white,
                  fontFamily: 'bold',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'СМС с кодом был отправлен на ваш номер ${widget.phone}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'regular',
                ),
              ),

              SizedBox(height: 30.h),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, buildBox),
                  ),
                  Opacity(
                    opacity: 0,
                    child: TextField(
                      controller: controller,
                      keyboardType: TextInputType.number,
                      maxLength: 5,
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {});
                        goToSuccess();
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    '00:${second.toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'medium',
                    ),
                  ),
                  Spacer(),
                  SizedBox(height: 10.h),
                  GestureDetector(
                    onTap: second == 0
                        ? () {
                            setState(() {
                              second = 59;
                              controller.clear();
                            });
                            startTimer();
                          }
                        : null,
                    child: Text(
                      'Отправить снова',
                      style: TextStyle(
                        color: second == 0 ? trueColor2 : Colors.white38,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'regular',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
