import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_glow_border/gradient_glow_border.dart';
import 'package:intl/intl.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/history/change_screen.dart';
import 'package:paynet_app/history/history_storage.dart';
import 'package:paynet_app/history/request_history.dart';
import 'package:paynet_app/widgets/cancel_request_button.dart';
import 'package:paynet_app/widgets/true_request_button.dart';
import '../error/success_no_page.dart';
import '../models/request_madel.dart';
import 'history_page.dart';

class RequestCheckPage extends StatefulWidget {
  final String name;
  final String amount;
  final String phone;
  final File? image;
  final Map<String, String> card;

  const RequestCheckPage({
    super.key,
    required this.name,
    required this.amount,
    required this.phone,
    required this.image,
    required this.card,
  });

  @override
  State<RequestCheckPage> createState() => _RequestCheckPageState();
}

class _RequestCheckPageState extends State<RequestCheckPage> {
  String getDayLabel(DateTime date) {
    final now = DateTime.now();

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Сегодня';
    }
    if (date.day == now.day - 1 &&
        date.month == now.month &&
        date.year == now.year) {
      return 'Вчера';
    }
    return DateFormat('dd.MM.yyyy').format(date);
  }

  final requestId = DateTime.now().day.toString();

  void createRequest(String requestId) async {
    final newRequest = RequestModel(
      id: requestId,
      status: 'В ожидании',
      name: widget.name,
      amount: widget.amount,
      dateTime: DateTime.now(),
    );
    requestHistory.insert(0, newRequest);
    await saveRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
            padding: EdgeInsets.all(24.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        createRequest(requestId);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HistoryPage(
                              amount: widget.amount,
                              name: widget.name,
                              phone: widget.phone,
                              image: widget.image,
                              card: widget.card,
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 40.w),
                    Text(
                      'Детали запроса',
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
                Container(
                  width: 380.w,
                  height: 64.h,
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: LinearGradient(
                        colors: [primaryColor, orangeColor],
                      ),
                      width: 1.5,
                    ),
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'medium',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            widget.phone,
                            style: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              fontFamily: 'medium',
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        'В ожидании',
                        style: TextStyle(
                          color: orangeColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'medium',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  width: 380.w,
                  height: 149.h,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Сумма запроса',
                          style: TextStyle(
                            color: Colors.white60,
                            fontSize: 14.sp,
                            fontFamily: 'regular',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.amount}',
                              style: TextStyle(
                                fontSize: 36.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'medium',
                                color: Colors.white,
                              ),
                            ),
                            Text('сум', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Divider(
                          height: 1.h,
                          color: Colors.grey.shade900,
                          thickness: 1,
                          indent: 30,
                          endIndent: 30,
                        ),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.only(left: 18.w, right: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Дата и время',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: 'regular',
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                DateFormat(
                                  'dd.MMM, HH:mm',
                                ).format(DateTime.now()),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'medium',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                SizedBox(
                  child: Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          widget.card['image']!,
                          width: 44.w,
                          height: 28.h,
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.card['number']!,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'medium',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.h),
                Divider(height: 1.h, color: Colors.grey.shade700, thickness: 0.5),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 60.h,
                  width: 380.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Center(
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Комментарий получателю',
                          hintStyle: TextStyle(
                            color: Colors.white54,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'regular',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                widget.image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.file(
                          widget.image!,
                          width: 380.w,
                          height: 180.h,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                Spacer(),

                SizedBox(
                  width: 380.w,
                  height: 56.h,
                  child: CancelRequestButton(
                    label: 'Отменить запрос',
                    height: 56.h,
                    borderRadius: 32.r,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return Center(
                            child: SizedBox(
                              height: 320.h,
                              child: Dialog(
                                insetPadding: EdgeInsets.symmetric(
                                  horizontal: 20.w,
                                  vertical: 24.h,
                                ),
                                backgroundColor: Color(0xFF16191D),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.r),
                                ),
                                child: Container(
                                  height: 360.h,
                                  decoration: BoxDecoration(
                                    border: GradientBoxBorder(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [primaryColor, redColor],
                                      ),
                                      width: 2.w,
                                    ),
                                    borderRadius: BorderRadius.circular(32.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.r),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Отменить запрос',
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: 'bold',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Center(
                                            child: Text(
                                              'вы уверены что хотите отменить запрос на ${widget.amount} сум к ${widget.name}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'regular',
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          Center(
                                            child: SizedBox(
                                              width: 360.w,
                                              height: 56.h,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: redColor,
                                                ),
                                                child: Text(
                                                  'Отменить запрос',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  createRequest(requestId);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SuccessNoPage(
                                                            requestId: requestId,
                                                            amount: widget.amount,
                                                            name: widget.name, phone: widget.phone, image: widget.image, card: widget.card,
                                                          ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 12.h),
                                          Center(
                                            child: TrueRequestButton(
                                              label: 'Назад',
                                              height: 56.h,
                                              borderRadius: 32.r,
                                              onPressed: () {
                                                Navigator.pop(context);
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
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 12.h),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      onPressed: () {
                        createRequest(requestId);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeScreen(
                              requestId: requestId,
                              amount: widget.amount,
                              name: widget.name,
                              phone: widget.phone,
                              image: widget.image,
                              card: widget.card,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        'Оплатить запрос',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
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
