import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:grocery_nxt/Pages/CartView/cart_view.dart';
import 'package:grocery_nxt/Pages/SwiggyView/Controller/swiggy_view_controller.dart';
import 'package:grocery_nxt/Pages/SwiggyView/Widgets/sub_category_item.dart';
import 'package:grocery_nxt/Pages/SwiggyView/Widgets/swiggy_view_product.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Constants/app_colors.dart';
import '../HomeScreen/Controller/cart_controller.dart';
import '../HomeScreen/Widgets/HomeProductsView/discount_wavy_bottom_container.dart';

class SwiggyView extends StatelessWidget {
   SwiggyView({super.key,this.categoryId,this.categoryName,this.imageUrl});

   SwiggyViewController svc = Get.put(SwiggyViewController());
   int    ?categoryId;
   String ?categoryName;
   String ?imageUrl;

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(svc.categoryId==null){
        svc.categoryId = categoryId;
        svc.categoryName = categoryName;
        svc.fetchSubCategories();
        svc.fetchCategoryProducts();
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        actions: [
          GestureDetector(
            onTap: (){
              Get.to(()=>CartView());
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: GetBuilder<CartController>(builder: (cc) {
                return Badge(
                    backgroundColor: AppColors.secondaryColor,
                    label: Text(cc.totalProducts.toString()),
                    child: const Icon(Icons.shopping_bag_outlined));
              }),
            ),
          )
        ],
        title: GetBuilder<SwiggyViewController>(
          builder: (vc) {
            return GestureDetector(
              onTap: (){
                showCategoriesDialog(context);
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageUrl!,
                    width: 40.w,
                    height: 40.h,
                  ),
                  SizedBox(width: 4.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Row(
                          children: [

                            Text(
                              vc.categoryName??"",
                              style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.9)
                              ),
                            ),

                            Icon(
                                Icons.keyboard_arrow_down,
                                size: 16.sp)

                          ],
                        ),
                      ),

                      GetBuilder<SwiggyViewController>(
                          builder: (vc) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [

                                Text(
                                    svc.totalCategoryProducts.toString()+" items",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.9)
                                    ),
                                )

                              ]
                            );
                          }
                      ),

                    ],
                  ),
                ],
              ),
            );
          }
        ),
      ),
      body: Container(
        color: Colors.grey.shade100,
        padding: EdgeInsets.only(top: 4.h),
        child: Row(
          children: [

            GetBuilder<SwiggyViewController>(
              builder: (vc) {
                return Expanded(
                    flex: 3,
                    child: Container(
                      height: MediaQuery.of(context).size.height-(kToolbarHeight+MediaQuery.of(context).viewPadding.top),
                      padding: EdgeInsets.only(top: 24.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                          border: Border.all(color: Colors.grey.shade400,width: 0.4),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.r))
                      ),
                      child: !vc.isLoadingSubCategories ?Stack(
                        children: [

                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: vc.subCategories.length,
                              itemBuilder: (context,index){
                                var sub = vc.subCategories[index];
                                return SubCategoryItem(subcategory: sub);
                              }
                          ),

                          AnimatedPositioned(
                            left: 0,
                            top: 24.h,
                            duration: Duration(milliseconds: 300),
                            child: Container(
                              height: 70.h,
                              width: 4.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12.r),
                                    bottomRight: Radius.circular(12.r)
                                )
                              ),
                            ),
                          )

                        ],
                      ):ListView.builder(
                          shrinkWrap: true,
                          itemCount: 6,
                          itemBuilder: (context,index){
                            return categoriesLoader();
                          }
                      ),
                    )
                );
              }
            ),

            SizedBox(width: 4.w),

            Expanded(
                flex: 12,
                child: Container(
                  height: MediaQuery.of(context).size.height-(kToolbarHeight+MediaQuery.of(context).viewPadding.top),
                  padding: EdgeInsets.only(top: 8.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade400,width: 0.4),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12.r),
                  )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                    
                        SizedBox(
                          height: kToolbarHeight*0.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                    
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: GetBuilder<SwiggyViewController>(
                                  builder: (vc) {
                                    return !vc.isLoading?Row(
                                      children: [
                    
                                        Text(
                                          svc.totalProducts.toString()+" items",
                                        style: TextStyle(fontWeight: FontWeight.w600)),
                    
                                        Text(" in ${svc.selectedSubCategory!=null
                                            ? svc.selectedSubCategory!.name!
                                            : ""}")
                    
                                      ],
                                    ): Container(
                                      width: MediaQuery.of(context).size.width * 0.20,
                                      height: MediaQuery.of(context).size.height*0.32*0.08,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                      ),
                                    );
                                  }
                                ),
                              ),
                    
                              Expanded(
                                  child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Divider(color: Colors.grey.shade300,thickness: 0.6,height: 0)))
                    
                            ],
                          ),
                        ),
                    
                        GetBuilder<SwiggyViewController>(
                          builder: (vc) {
                            return !vc.isLoading?GridView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                                itemCount: svc.products.length,
                                physics: NeverScrollableScrollPhysics(),
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: MediaQuery.of(context).size.height*0.34,
                                ),
                                itemBuilder: (context,index){
                                  var product = svc.products[index];
                                  return SwiggyViewProduct(
                                      product: product,
                                      index: index,
                                  );
                                }
                            ):GridView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: 6,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: MediaQuery.of(context).size.height*0.34,
                                ),
                                itemBuilder: (context,index){
                                  return loader(context,index);
                                }
                            );
                          }
                        ),
                      ],
                    ),
                  ),
                )
            ),

          ],
        ),
      ),
    );
  }


  //
   showCategoriesDialog(BuildContext context) async {

    await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            contentPadding: EdgeInsets.all(1.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            content: GetBuilder<SwiggyViewController>(builder: (vc){
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r)
                    ),
                    width: MediaQuery.of(context).size.width*0.9,
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Container(
                          height: kToolbarHeight,
                          margin: EdgeInsets.only(top: 16.h),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                  "Shop By Categories",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),

                              Text(vc.categories.length.toString()+" Categories")

                            ],
                          ),
                        ),

                        Divider(),

                        GridView.builder(
                          itemCount: svc.categories.length,
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisExtent: 90.h,
                              crossAxisSpacing: 1.w,
                              mainAxisSpacing: 10.w
                          ), itemBuilder: (BuildContext context, int index) {
                          var category = svc.categories[index];
                          return GestureDetector(
                            onTap: (){
                              vc.categoryId = category.id;
                              vc.categoryName = category.name;
                              imageUrl = category.imageUrl;
                              vc.fetchSubCategories();
                              vc.fetchCategoryProducts();
                              Get.back();
                            },
                            child: Column(
                              children: [

                                Expanded(
                                  flex: 8,
                                  child: CachedNetworkImage(
                                      imageUrl: category!.imageUrl!,
                                      width: 60.w,
                                      height: 60.h,
                                  ),
                                ),

                                SizedBox(height: 4.h),

                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    category.name!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12.sp
                                    ),
                                  ),
                                )

                              ],
                            ),
                          );
                        },
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      height: 60.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                          Colors.white,
                              Colors.white.withOpacity(0.8),
                          Colors.white.withOpacity(0.2)
                        ])
                      ),
                    ),
                  )

                ],
              );
            }),
          );
        });
   }

  //
  Widget loader(BuildContext context,int index){

    return Skeletonizer(
      child: Container(
        decoration: BoxDecoration(
            border: index==0
                ? Border(
                right: BorderSide(
                  color: Colors.grey.shade200,
                ),
                bottom: BorderSide(color: Colors.grey.shade200)
            )
                : Border(
                right: BorderSide(color: Colors.grey.shade200),
                bottom: BorderSide(color: Colors.grey.shade200)
            )
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.h, left: 4.w, right: 4.w),
                  child: Column(
                    children: [

                      GestureDetector(
                        onTap: (){
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              width: MediaQuery.of(context).size.width * 0.34,
                              height: MediaQuery.of(context).size.height*0.32*0.4,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12.r)
                              ),
                            ),

                            SizedBox(height: 12.h),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.32,
                              height: MediaQuery.of(context).size.height*0.32*0.08,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                              ),
                            ),

                            SizedBox(height: 6.h),

                            Container(
                              width: MediaQuery.of(context).size.width * 0.20,
                              height: MediaQuery.of(context).size.height*0.32*0.08,
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                              ),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.28*0.4,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "",
                                      style: TextStyle(
                                        color: AppColors.secondaryColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child:  Container(
                                          width: MediaQuery.of(context).size.width * 0.20,
                                          height: MediaQuery.of(context).size.height*0.32*0.08,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade100,
                                          ),
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),

                      SizedBox(height: 6.h),

                    ],
                  ),
                ),

                /*Positioned(
                right: 8.w,
                top: 8.h,
                child:
                GetBuilder<WishlistController>(builder: (wc) {
                  var isFavourite = wc.products
                      .firstWhere(
                          (element) =>
                      element.prdId == product!.prdId,
                      orElse: () => Product())
                      .prdId !=
                      null;
                  return GestureDetector(
                    onTap: () {
                      wc.addOrRemoveProduct(
                          product: product,
                          isFavourite: isFavourite);
                    },
                    child: isFavourite
                        ? Icon(
                      Icons.favorite,
                      color: AppColors.primaryColor.withOpacity(0.6),
                    )
                        : Icon(
                      Icons.favorite_border,
                      color: Colors.grey.shade400,
                    ),
                  );
                }),
              )*/
              ],
            )
          ],
        ),
      ),
    );
  }

  //
  categoriesLoader(){

    return SizedBox(
      height: 100.h,
      child: Column(
        children: [

          AnimatedContainer(
            duration: const Duration(milliseconds: 350),
            width: 50.w,
            height: 56.h,
            padding: EdgeInsets.only(top: 12.h),
            decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey.shade400,width: 0.2),
              color:  Colors.grey.shade200,
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
            )
          ),

        ],
      ),
    );
  }

}
