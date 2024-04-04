import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_nxt/Pages/ChooseAddressView/Controller/choose_address_controller.dart';
import 'package:grocery_nxt/Pages/OrderSuccessScreen/order_success_screen.dart';
import 'package:grocery_nxt/Pages/Payment%20Screen/Controller/payment_controller.dart';
import 'package:grocery_nxt/Widgets/custom_appbar.dart';
import '../../Constants/app_colors.dart';
import '../../Widgets/custom_button.dart';
import '../HomeScreen/Controller/cart_controller.dart';

class PaymentScreen extends StatelessWidget {
   PaymentScreen({super.key});

   PaymentController vc = Get.put(PaymentController());
   CartController    cc = Get.find<CartController>();
   ChooseAddressController addressController = Get.find<ChooseAddressController>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment Screen',
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 16.h),

            Text(
              "Shipping To",
              style: TextStyle(
                color: Color(0xff2B3241),
                fontWeight: FontWeight.w600,
                fontSize: 18.sp
              ),
            ),

            Container(
              margin: EdgeInsets.symmetric(vertical: 16.h),
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 2,
                        offset: Offset(0,1)
                    )
                  ]
              ),
              child: ListTile(
                leading: Container(
                  width: 55.w,
                  height: 55.w,
                  padding: EdgeInsets.all(1.2.w),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 3,
                        )
                      ]
                  ),
                  child: Stack(
                    children: [

                      Image.asset("assets/images/map.png"),

                      Center(
                        child: Container(
                          width: 30.w,
                          height: 30.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle
                          ),
                          child: Icon(Icons.location_on),
                        ),
                      )
                    ],
                  ),
                ),
                title: Text(
                    addressController.selectedAddress!.name,
                    style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                )),
                subtitle: Text(addressController.selectedAddress!.address!),
              ),
            ),

            Text(
                "Add Payment Method",
              style: TextStyle(
                  color: Color(0xff2B3241),
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp
              ),
            )

          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 20.w,right: 20.w,bottom: 16.h),
        child: CustomButton(
          child: const Text(
            "Place Order",
            style: TextStyle(color: Colors.white)),
          onTap: (){
            Get.to(()=> OrderSuccessScreen());
          },
        ),
      ),
    );
  }
}
