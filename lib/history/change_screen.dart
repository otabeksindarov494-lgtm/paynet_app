import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/error/success_no_page.dart';
import 'package:paynet_app/history/new_sum_screen.dart';
import 'package:paynet_app/history/request_check_page.dart';
import 'package:paynet_app/pages/password_page.dart';
import 'package:paynet_app/widgets/cancel_request_button.dart';

import '../widgets/bottom_sheet_border.dart';
import '../widgets/true_request_button.dart';

class ChangeScreen extends StatefulWidget {
  const ChangeScreen({
    super.key,
    required this.name,
    required this.amount,
    required this.requestId,
    required this.phone,
    required this.image,
    required this.card,
  });

  final String name;
  final String amount;
  final String requestId;
  final String phone;
  final File? image;
  final Map<String, String> card;

  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    _amountController.addListener(() {
      final text = _amountController.text.replaceAll('', '');
      final amount = int.tryParse(text) ?? 0;

      setState(() {
        isButtonEnabled = amount >= 1000000;
      });
    });
  }

  int selectedCardIndex = 0;

  final cards = [
    {
      'amount': '250 678 сум',
      'number': '6544 * Ipak Yuli UzCard',
      'image': 'assets/images/uzcard.png',
    },
    {
      'amount': '345 222 сум',
      'number': '3456 * Ipak Yuli Humo',
      'image': 'assets/images/img_5.png',
    },
    {
      'amount': '120 342 сум',
      'number': '1254 * Ipak Yuli UzCard',
      'image': 'assets/images/uzcard.png',
    },
  ];

  final item = [
    {'icon': Icons.image, 'title': 'Выбрать из галереи'},
    {'icon': Icons.camera_alt, 'title': 'Снять фото'},
  ];

  final TextEditingController _amountController = TextEditingController();

  void _showCards(BuildContext context) {
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
                    height: 360.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10.h),
                        Center(
                          child: Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 24.w, top: 23.h),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Карты',
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'bold',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),

                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: cards.length,
                            itemBuilder: (context, index) {
                              final card = cards[index];
                              return Column(
                                children: [
                                  Divider(
                                    height: 1.h,
                                    color: dividerColor,
                                    thickness: 1,
                                    indent: 80,
                                    endIndent: 30,
                                  ),
                                  ListTile(
                                    leading: Image.asset(
                                      card['image']!,
                                      width: 44.w,
                                      height: 28.h,
                                    ),
                                    title: Text(
                                      card['amount']!,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'medium',
                                      ),
                                    ),
                                    subtitle: Text(
                                      card['number']!,
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'medium',
                                      ),
                                    ),
                                    trailing: selectedCardIndex == index
                                        ? Icon(
                                            Icons.check_circle_sharp,
                                            color: Color(0xFF54C59C),
                                          )
                                        : null,
                                    onTap: () {
                                      setState(() {
                                        selectedCardIndex = index;
                                      });
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Padding(
                          padding: EdgeInsets.only(bottom: 15.h),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  color: primaryColor,
                                  width: 44.w,
                                  height: 28.h,
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 24.sp,
                                  ),
                                ),
                                title: Text(
                                  'Добавить карту',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontFamily: 'medium',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ],
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

  void _showImage(BuildContext context) {
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
                    height: 230.h,
                    child: Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Container(
                              width: 40.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, bottom: 10.h),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Другие действия',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'bold',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 396.w,
                            child: TrueRequestButton(
                              label: 'Изменить сумму',
                              height: 56.h,
                              borderRadius: 30.r,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewSumScreen(
                                      amount: widget.amount,
                                      name: widget.name,
                                      phone: widget.phone,
                                      card: widget.card,
                                      image: widget.image,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 15.h),
                          SizedBox(
                            width: 396.w,
                            height: 56.h,
                            child: CancelRequestButton(
                              label: 'Отменить запрос',
                              height: 56.h,
                              borderRadius: 30.r,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SuccessNoPage(
                                      amount: widget.amount,
                                      name: widget.name,
                                      requestId: widget.requestId,
                                      phone: widget.phone,
                                      image: widget.image,
                                      card: widget.card,
                                    ),
                                  ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                              phone: widget.phone,
                              card: widget.card,
                              image: widget.image,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 25.w),
                    Text(
                      'Оплатить запрос',
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
                Text(
                  'Отправитель запроса',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'regular',
                  ),
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: 360.w,
                  height: 64.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 10.h,
                    ),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'medium',
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              widget.phone,
                              style: TextStyle(
                                color: greyColor,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'medium',
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          widget.amount,
                          style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'medium',
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Padding(
                          padding: EdgeInsets.only(bottom: 1.h),
                          child: Text(
                            'сум',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Карта для оплаты',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'regular',
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    _showCards(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          cards[selectedCardIndex]['image']!,
                          width: 44.w,
                          height: 28.h,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cards[selectedCardIndex]['amount']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'medium',
                              ),
                            ),
                            Text(
                              cards[selectedCardIndex]['number']!,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'medium',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 12.w),

                        Spacer(),
                        Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                Divider(
                  height: 15.h,
                  color: Colors.grey.shade700,
                  thickness: 0.5,
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Комиссия',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'regular',
                      ),
                    ),
                    Text(
                      '0 сум',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'medium',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Итого к оплате',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'regular',
                          ),
                        ),
                        Text(
                          '${widget.amount}сум',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'medium',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 3.w),
                  child: SingleChildScrollView(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 300.w,
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
                                    builder: (context) => PasswordPage(
                                      name: widget.name,
                                      amount: widget.amount,
                                      requestId: widget.requestId,
                                      phone: widget.phone,
                                      card: widget.card,
                                      image: widget.image,
                                    ),
                                  ),
                                );
                              },
                              child: Text(
                                'Оплатить',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {
                            _showImage(context);
                          },
                          child: Image.asset(
                            'assets/images/img_26.png',
                            width: 55.w,
                            height: 55.w,
                          ),
                        ),
                      ],
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
