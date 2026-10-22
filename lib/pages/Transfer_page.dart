import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/last_transfers.dart';
import '../widgets/search_field.dart';
import '../widgets/title_widget.dart';
import '../widgets/transfer_grid.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.all(16.r),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(),
                  SizedBox(height: 20.h),
                  SearchField(),
                  SizedBox(height: 20.h),
                  TransferGrid(),
                  SizedBox(height: 20.h),
                  LastTransfers(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
