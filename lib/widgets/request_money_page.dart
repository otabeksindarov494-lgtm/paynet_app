import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_glow_border/gradient_glow_border.dart';
import 'package:paynet_app/color/colors.dart';
import 'package:paynet_app/widgets/bottom_sheet_border.dart';
import 'package:paynet_app/widgets/success_page.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../images/images.dart';
import 'number_format.dart';

class RequestMoneyPage extends StatefulWidget {
  final String name;
  final String phone;

  const RequestMoneyPage({super.key, required this.name, required this.phone});

  @override
  State<RequestMoneyPage> createState() => _RequestMoneyPageState();
}

class _RequestMoneyPageState extends State<RequestMoneyPage> {
  final ImagePicker picker = ImagePicker();
  File? image;

  @override
  void initState() {
    super.initState();
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
    {'image': img22, 'title': 'Выбрать из галереи'},
    {'image': img23, 'title': 'Снять фото'},
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

                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 15.h),
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
                                        fontFamily: 'medium',
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle: Text(
                                      card['number']!,
                                      style: TextStyle(
                                        color: Colors.white60,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'medium',
                                      ),
                                    ),
                                    trailing: selectedCardIndex == index
                                        ? Image.asset(
                                            'assets/images/img_27.png',
                                            width: 24,
                                            height: 24,
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

  Future<void> _pickFromGallery() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
  }

  Future<void> _pickFromCamera() async {
    final XFile? file = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );
    if (file != null) {
      setState(() {
        image = File(file.path);
      });
    }
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
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 10.h),
                        Center(
                          child: Container(
                            width: 40.w,
                            height: 4.h,
                            decoration: BoxDecoration(
                              color: sheetColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                          ),
                        ),

                        SizedBox(
                          width: 428,
                          height: 115.h,
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 5.h),
                            itemCount: item.length,
                            itemBuilder: (context, index) {
                              final items = item[index];
                              return Column(
                                children: [
                                  ListTile(
                                    leading: SizedBox(
                                      width: 30.w,
                                      height: 30.h,
                                      child: FittedBox(
                                        fit: BoxFit.contain,
                                        child: items['image']! as Widget,
                                      ),
                                    ),
                                    title: Text(
                                      items['title']! as String,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'medium',
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pop(context);

                                      if (index == 0) {
                                        _pickFromGallery();
                                      } else if (index == 1) {
                                        _pickFromCamera();
                                      }
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedCard = cards[selectedCardIndex];
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
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    SizedBox(width: 50.w),
                    Text(
                      'Запрос денег',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'bold',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Text(
                  'Получатель запроса',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontFamily: 'regular',
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 10.h),
                Container(
                  width: 380.w,
                  height: 64.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
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
                              fontFamily: 'medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
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
                      Icon(Icons.keyboard_arrow_down, color: Colors.white54),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Container(
                  height: 120.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IntrinsicWidth(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            NumberFormatter(),
                            MaxValueInputFormatter(maxValue: 100000000),
                          ],
                          autofocus: false,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 36.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'medium',
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: 'medium',
                              fontWeight: FontWeight.w500,
                              fontSize: 36.sp,
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 1.h),
                        child: Text(
                          'сум',
                          style: TextStyle(
                            color: greyColor,
                            fontFamily: 'regular',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Карта для зачисления',
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
                                fontWeight: FontWeight.w500,
                                fontFamily: 'medium',
                              ),
                            ),
                            Text(
                              cards[selectedCardIndex]['number']!,
                              style: TextStyle(color: Colors.white54),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 18.h),
                Divider(height: 1.h, color: dividerColor, thickness: 0.5),
                SizedBox(height: 18.h),
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
                SizedBox(height: 20.h),
                image == null
                    ? InkWell(
                        onTap: () {
                          _showImage(context);
                        },
                        child: SizedBox(
                          width: 380.w,
                          height: 60.h,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Приложить изображение',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 14.sp,
                                    fontFamily: 'regular',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Spacer(),
                                Image.asset(
                                  'assets/images/img_22.png',
                                  width: 24.w,
                                  height: 24.h,
                                  color: greyColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(16.r),
                        child: Image.file(
                          image!,
                          width: 380.w,
                          height: 180.h,
                          fit: BoxFit.cover,
                        ),
                      ),

                Spacer(),

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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SuccessPage(
                              amount: _amountController.text,
                              name: widget.name,
                              phone: widget.phone,
                              image: image,
                              card: selectedCard,
                            ),
                          ),
                        );
                      },

                      child: Text(
                        'Запросить',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
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
