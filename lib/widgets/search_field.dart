import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:gradient_glow_border/gradient_glow_border.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: SizedBox(
        width: 380.w,
        height: 60.h,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: LinearGradient(colors: [Colors.transparent, trueColor2]),
            ),
            color: primaryColor,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Карта или телефон',
                    hintStyle: TextStyle(
                      color: greyColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'regular',
                    ),
                  ),
                ),
              ),
              Image.asset('assets/images/img_24.png', width: 24.w, height: 24.w,),
              SizedBox(width: 10.w),
              Image.asset('assets/images/img_6.png', width: 24.h, height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
