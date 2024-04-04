import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_nxt/Constants/app_colors.dart';
import 'package:grocery_nxt/Widgets/custom_button.dart';
import '../Model/order_list_model.dart';

class OrderListItem extends StatelessWidget {
   OrderListItem({super.key,this.order});

   Order ?order;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 106.h,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: 24.w,
            vertical: 10.h),
        child: Row(
          children: [

            Container(
              width: 85.w,
              height: 85.w,
              decoration: BoxDecoration(
               color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),

            SizedBox(
              width: 16.w,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              
                  Text(
                      "# "+order!.invoiceNumber.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600
                      ),
                  ),
              
                  Text(
                      order!.paymentStatus!.capitalizeFirst.toString(),
                      style: TextStyle(
                        color: Color(0xffb9b9b9)
                      ),
                  ),
              
                  Text(
                      "\u{20B9} "+order!.paymentMeta!.totalAmount!.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w600
                    ),
                  )
              
                ],
              ),
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: CustomButton(
                  width: 80.w,
                  height: 28.h,
                  onTap: (){

                  },
                  child: Text("Details",style: TextStyle(color: Colors.white),),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
