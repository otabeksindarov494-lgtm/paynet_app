import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/widgets/true_request_button.dart';

class CancelRequestDialog extends StatelessWidget {
  final String amount;
  final String name;
  final VoidCallback onConfirmCancel;

  const CancelRequestDialog({
    super.key,
    required this.amount,
    required this.name,
    required this.onConfirmCancel,
  });

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        'вы уверены что хотите отменить запрос на $amount сум к $name',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'regular',
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
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
                          onPressed: onConfirmCancel,
                          child: Text(
                            'Отменить запрос',
                            style: TextStyle(color: Colors.white),
                          ),
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
  }
}
