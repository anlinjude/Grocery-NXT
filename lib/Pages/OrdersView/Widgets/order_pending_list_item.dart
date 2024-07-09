import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:grocery_nxt/Constants/app_colors.dart';
import 'package:grocery_nxt/Pages/OrderDetailsView/order_details_view.dart';
import 'package:grocery_nxt/Pages/OrdersView/Controller/order_controller.dart';
import '../Model/order_pending_list_model.dart';

class OrderPendingListItem extends StatelessWidget {
  OrderPendingListItem({super.key, this.order, this.index});

  SubordersDatum? order;
  int? index;
  OrderController vc = Get.find<OrderController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var result =
        await Get.to(() => OrderDetailsView(orderId: order!.orderId));
        if (result == 1) {
          vc.getOrders();
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 88.h,
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        child: Row(
          children: [
            Container(
              width: 70.w,
              height: 70.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: order!.orderItem!.length == 2
                  ? ListView.builder(
                  itemCount: order!.orderItem!.length,
                  scrollDirection: Axis.horizontal,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var image = order!.orderItem![index].product!.image;
                    return CachedNetworkImage(
                      imageUrl:
                      "https://grocerynxt.ltcloud247.com/assets/uploads/media-uploader/${image!.path}",
                      width: 35.w,
                    );
                  })
                  : order!.orderItem!.length > 1
                  ? GridView.builder(
                  itemCount: order!.orderItem!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    var image = order!.orderItem![index].product!.image;
                    return CachedNetworkImage(
                        imageUrl:
                        "https://grocerynxt.ltcloud247.com/assets/uploads/media-uploader/${image!.path}");
                  })
                  : CachedNetworkImage(
                  imageUrl:
                  "https://grocerynxt.ltcloud247.com/assets/uploads/media-uploader/${order!.orderItem![0].product!.image!.path}"),
            ),
            SizedBox(
              width: 16.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("#${order!.order!.invoiceNumber}"),
                  Text(
                    order!.orderItem![0].product!.name.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: Colors.grey.shade500,
                        overflow: TextOverflow.ellipsis),
                  ),
                  order!.orderItem!.length > 1
                      ? Text(
                    order!.orderItem![0].product!.name.toString(),
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: Colors.grey.shade500,
                        overflow: TextOverflow.ellipsis),
                  )
                      : const SizedBox(),
                  Text(
                    "\u{20B9} ${double.parse(order!.totalAmount!).toStringAsFixed(0)}",
                  )
                ],
              ),
            ),
            /*Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: CustomButton(
                  width: 80.w,
                  height: 24.h,
                  child: const Text(
                    "Details",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
