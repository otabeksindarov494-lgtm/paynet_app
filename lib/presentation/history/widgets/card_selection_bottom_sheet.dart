import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/widgets/bottom_sheet_border.dart';

class CardSelectionBottomSheet extends StatelessWidget {
  final List<Map<String, String>> cards;
  final int selectedCardIndex;
  final ValueChanged<int> onCardSelected;

  const CardSelectionBottomSheet({
    super.key,
    required this.cards,
    required this.selectedCardIndex,
    required this.onCardSelected,
  });

  static void show(
    BuildContext context, {
    required List<Map<String, String>> cards,
    required int selectedCardIndex,
    required ValueChanged<int> onCardSelected,
  }) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.2),
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return CardSelectionBottomSheet(
          cards: cards,
          selectedCardIndex: selectedCardIndex,
          onCardSelected: onCardSelected,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
                                  onCardSelected(index);
                                  Navigator.pop(context);
                                },
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
        ),
      ],
    );
  }
}
