import 'package:animated_search_bar/animated_search_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:grocery_nxt/Pages/AllProductsView/all_products_view.dart';
import 'package:grocery_nxt/Pages/CategoriesView/Controller/categories_view_controller.dart';
import 'package:grocery_nxt/Pages/CategoriesView/Widgets/top_curve.dart';
import 'package:grocery_nxt/Widgets/custom_button.dart';
import 'package:grocery_nxt/Widgets/custom_circular_loader.dart';
import '../../Constants/app_colors.dart';

class CategoriesView extends StatelessWidget {
  CategoriesView({super.key});

  CategoriesViewController vc = Get.put(CategoriesViewController());

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            scrolledUnderElevation: 0,
            title: SizedBox(
              height: 40.h,
              child: AnimatedSearchBar(
                label: "                 Categories",
                  controller: vc.searchTEC,
                  labelAlignment: Alignment.center,
                  animationDuration: const Duration(milliseconds: 3000),
                  duration: const Duration(milliseconds: 3000),
                  labelStyle: TextStyle(fontSize: 16.sp,color: Colors.white),
                  searchStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                  cursorColor: Colors.black,
                  textInputAction: TextInputAction.done,
                  searchIcon: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200)),
                    child: const Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    vc.searchCategories();
                  },
                  onFieldSubmitted: (value) {
                    debugPrint('value on Field Submitted');
                  }),
            ),
            centerTitle: true,
            actions: [
              /*Container(
                width: 40.w,
                height: 40.h,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade200)),
                child: const Icon(Icons.search),
              )*/
            ],
          ),
          body: GetBuilder<CategoriesViewController>(builder: (vc) {
            return vc.loading
                ? CustomCircularLoader()
                : vc.categories.isEmpty
                    ? Center(
                        child: CustomButton(
                          onTap: () {
                            vc.fetchCategories();
                          },
                          child: const Text("Load Categories",style: TextStyle(color: Colors.white)),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: [

                            SizedBox(height: 24.h),

                            AnimationLimiter(
                              child: GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 12.h),
                                  shrinkWrap: true,
                                  itemCount: vc.searchedCategories.isNotEmpty
                                      ? vc.searchedCategories.length
                                      : vc.categories.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 8.w,
                                          mainAxisSpacing: 8.h,
                                          mainAxisExtent:
                                              MediaQuery.of(context).size.height *
                                                  0.20),
                                  itemBuilder: (context, index) {
                                    var category;
                                    if(vc.searchedCategories.isNotEmpty){
                                      category = vc.searchedCategories[index];
                                    }else{
                                      category = vc.categories[index];
                                    }
                                    return AnimationConfiguration.staggeredGrid(
                                      position: index,
                                      columnCount: 2,
                                      duration: const Duration(milliseconds: 500),
                                      child: DefaultTextStyle(
                                        style: TextStyle(fontSize: 10.sp),
                                        child: SlideAnimation(
                                          verticalOffset: 50.h,
                                          child: FadeInAnimation(
                                            child: GestureDetector(
                                              onTap: () {
                                                Get.to(() => AllProductsView(
                                                      category: category,
                                                    ));
                                              },
                                              child: Container(
                                                padding: EdgeInsets.only(
                                                    top: 0.h, left: 0.w, right: 0.w),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(12.r),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: Stack(
                                                  children: [
                                                    CachedNetworkImage(
                                                      imageUrl: category!.imageUrl ?? "",
                                                      fit: BoxFit.fitHeight,
                                                      height: MediaQuery.of(context).size.height * 0.20,
                                                      errorWidget: (c, w, o) {
                                                        return Image.asset(
                                                            "assets/images/gnxt_logo.png");
                                                      },
                                                    ),
                                                    SizedBox(height: 16.h),
                                                    Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Container(
                                                        width: double.infinity,
                                                        height: MediaQuery.of(context).size.height * 0.04,
                                                        decoration: BoxDecoration(
                                                          gradient: LinearGradient(
                                                              begin: Alignment.bottomCenter,
                                                              end: Alignment.topCenter,
                                                              colors: [
                                                            //AppColors.primaryColor.withOpacity(0.9),
                                                            //AppColors.primaryColor.withOpacity(0.2)
                                                                Colors.black.withOpacity(0.8),
                                                                Colors.black.withOpacity(0.01)
                                                          ])
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.bottomCenter,
                                                      child: Padding(
                                                        padding: EdgeInsets.only(bottom: 6.h),
                                                        child: Text(
                                                          category.name!.toUpperCase(),
                                                          textAlign: TextAlign.center,
                                                          maxLines: 2,
                                                          style: TextStyle(fontSize: 11.sp,color: Colors.white),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                            )
                          ],
                        ),
                      );
          }),
        ),

        TopCurve()

      ],
    );
  }

  //
  InputDecoration decoration({String hint = "", Color? borderColor}) {
    borderColor = Color(0xffD7DFE9);
    return InputDecoration(
      disabledBorder: InputBorder.none,
      //errorStyle: GoogleFonts.jost(),
      focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.3)),
      isDense: true,
      filled: true,
      //contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 15.h),
      fillColor: Colors.white.withOpacity(0.2),
      counterText: "",
      hintText: hint,
      hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.4),
          fontSize: 12,
          fontWeight: FontWeight.w400),
      enabled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
          // width: 0.90,
          color: borderColor ?? Colors.transparent,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
            color: borderColor ??
                Colors.transparent), // Set border color to transparent
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
            color: borderColor ??
                Colors.transparent), // Set border color to transparent
      ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(borderRadius ?? 24.5.r),
      // ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 0.3), // Set border color to transparent
      ),
      // focusedBorder: OutlineInputBorder(
      //     borderRadius: BorderRadius.circular(borderRadius ?? 24.5.r),
      //     borderSide: const BorderSide(width: 0.5))
    );
  }


}
