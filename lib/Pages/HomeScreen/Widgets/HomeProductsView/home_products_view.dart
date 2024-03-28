import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_nxt/Pages/HomeScreen/Controller/home_controller.dart';
import 'package:grocery_nxt/Pages/HomeScreen/Widgets/HomeProductsView/product_list_item.dart';
import 'package:lottie/lottie.dart';

class HomeProductsView extends StatelessWidget {
  HomeProductsView({super.key});

  HomeController hc = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
          child: Row(
            children: [

              Text(
                "You might need",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),

              SizedBox(
                  width: 25,
                  child: Lottie.asset('assets/animations/hot_items_fire.json')
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "See All",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),

        SizedBox(height: 4.h),

        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              padding: EdgeInsets.only(left: 8.w),
              itemBuilder: (context, index) {
                return ProductListItem(index: index);
              }),
        ),
      ],
    );
  }
}
