import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:intl/intl.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/history/final_page.dart';
import 'package:paynet_app/history/request_history.dart';
import 'package:paynet_app/widgets/navigation_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({
    super.key,
    required this.amount,
    required this.name,
    required this.phone,
    required this.image,
    required this.card,
  });

  final String amount;
  final String name;
  final String phone;
  final File? image;
  final Map<String, String> card;

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
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
            padding: EdgeInsets.all(20.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationPage(),
                        ),
                      ),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'История',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'bold',
                        color: Colors.white,
                      ),
                    ),

                    SizedBox(width: 200.w),
                    Image.asset(
                      'assets/images/img_25.png',
                      width: 19.w,
                      height: 14.h,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                    itemCount: requestHistory.length,
                    itemBuilder: (context, index) {
                      final item = requestHistory[index];
                      final isFirst =
                          index == 0 ||
                          getDayLabel(requestHistory[index - 1].dateTime) !=
                              getDayLabel(item.dateTime);

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isFirst)
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Text(
                                getDayLabel(item.dateTime),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'bold',
                                ),
                              ),
                            ),
                          SizedBox(height: 8.h),

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FinalPage(
                                    name: widget.name,
                                    amount: widget.amount,
                                    phone: widget.phone,
                                    image: widget.image,
                                    card: widget.card, status: item.status,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 8.h),
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.w,
                                vertical: 10.h,
                              ),
                              decoration: BoxDecoration(
                                border: GradientBoxBorder(
                                  gradient: getStatusGradient(item.status),
                                  width: 1.5,
                                ),
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  item.status == 'Успешно'
                                      ? Icon(
                                          getStatusIcon(item.status),
                                          color: Colors.white,
                                          size: 20.sp,
                                        )
                                      : Icon(
                                          getStatusIcon(item.status),
                                          color: Colors.white,
                                          size: 20.sp,
                                        ),
                                  SizedBox(width: 5.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      item.status == 'Успешно'
                                          ? Text(
                                              item.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'medium',
                                                fontSize: 14.sp,
                                              ),
                                            )
                                          : Text(
                                              'запрос на ${item.amount} сум',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'medium',
                                                fontSize: 14.sp,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        DateFormat(
                                          'dd.MM',
                                        ).format(item.dateTime),
                                        style: TextStyle(
                                          color: greyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'medium',
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  item.status == 'Успешно'
                                      ? Text(
                                          '${item.amount} сум',
                                          style: TextStyle(
                                            color: getStatusColor(item.status),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                          ),
                                        )
                                      : Text(
                                          item.status,
                                          style: TextStyle(
                                            color: getStatusColor(item.status),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
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

  IconData getStatusIcon(String status) {
    switch (status) {
      case 'В ожидании':
        return Icons.arrow_upward;
      case 'Отменен':
        return Icons.arrow_downward;
      default:
        return Icons.north_east;
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
