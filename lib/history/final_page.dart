import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_glow_border/gradient_glow_border.dart';
import 'package:intl/intl.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/history/history_storage.dart';
import 'package:paynet_app/history/request_history.dart';
import 'package:paynet_app/widgets/navigation_page.dart';
import '../models/request_madel.dart';

class FinalPage extends StatefulWidget {
  final String name;
  final String amount;
  final String phone;
  final File? image;
  final Map<String, String> card;
  final String status;

  const FinalPage({
    super.key,
    required this.name,
    required this.amount,
    required this.phone,
    required this.image,
    required this.card, required this.status,
  });

  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
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
                            builder: (_) => NavigationPage(),
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
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: GradientBoxBorder(
                      gradient: getStatusGradient(widget.status),
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
                        widget.status,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: getStatusColor(widget.status),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
  Color getStatusColor(String status) {
    switch (status) {
      case 'Успешно':
        return Colors.white;
      case 'Отменен':
        return Colors.red;
      default:
        return orangeColor;
    }
  }
  Gradient getStatusGradient(String status) {
    switch (status) {
      case 'Успешно':
        return LinearGradient(colors: [primaryColor, trueColor2]);
      case 'Отменен':
        return LinearGradient(colors: [primaryColor, redColor]);
      default:
        return LinearGradient(colors: [primaryColor, orangeColor]);
    }
  }
}
