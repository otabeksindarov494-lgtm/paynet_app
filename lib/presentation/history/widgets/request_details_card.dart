import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:paynet_app/color/colors.dart';

class RequestDetailsCard extends StatelessWidget {
  final String amount;
  final DateTime dateTime;

  const RequestDetailsCard({
    super.key,
    required this.amount,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  amount,
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
                    DateFormat('dd.MMM, HH:mm').format(dateTime),
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
    );
  }
}
