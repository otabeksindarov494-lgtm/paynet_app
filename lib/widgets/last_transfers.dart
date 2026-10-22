import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/images/images.dart';

class LastTransfers extends StatelessWidget {
  const LastTransfers({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {'image': humoCardImage, 'title': 'Sindarov Otabek'},
      {'image': uzCardImage, 'title': 'Xolmatov Alisher'},
      {'image': humoCardImage, 'title': 'Sindarov Javohir'},
      {'image': humoCardImage, 'title': 'Sindarov Javohir'},
      {'image': humoCardImage, 'title': 'Sindarov Javohir'},
      {'image': humoCardImage, 'title': 'Sindarov Javohir'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: Text(
            'Последние переводы',
            style: TextStyle(
              fontFamily: 'bold',
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(width: 380.w, height: 18.h),
        ...users.map(
          (e) => Container(
            margin: EdgeInsets.only(bottom: 10.h, top: 3.h, right: 16.w, left: 16.w),
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Row(
              children: [
                SizedBox(child: e['image'] as Widget),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    e['title'] as String,
                    style: TextStyle(color: Colors.white, fontFamily: 'regular', fontSize: 14.sp, fontWeight: FontWeight.w400),
                  ),
                ),
                Spacer(),
                Text('**4413', style: TextStyle(color: Colors.white, fontFamily: 'regular', fontSize: 14.sp, fontWeight: FontWeight.w400)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
