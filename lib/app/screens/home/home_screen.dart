import 'package:family_events_app/app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import '../../app_widgets/app_drawer.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Center(child: Text('NTU Family')),
        backgroundColor: MyColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.indigoAccent.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Family Statistics",
                    style: Get.textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: MyColors.shimmerHighlightColor
                    )
                  ),
                  const SizedBox(height: 4.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "Family Events",
                                style: Get.textTheme.titleSmall?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: MyColors.shimmerHighlightColor
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Obx(
                                () => Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.orange, // Change to your desired color
                                  width: 2.0, // Change to your desired width
                                ),
                              ),
                              child: Text(
                                '${controller.events.value}',
                                style: Get.textTheme.titleLarge?.copyWith(

                                    color: MyColors.shimmerHighlightColor
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.purple,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "Family Tasks",
                                style: Get.textTheme.titleSmall?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                    color: MyColors.shimmerHighlightColor
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Obx(
                                () => Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.orange, // Change to your desired color
                                  width: 2.0, // Change to your desired width
                                ),
                              ),
                              child: Text(
                                '${controller.tasks.value}',
                                style: Get.textTheme.titleLarge?.copyWith(
                                    color: MyColors.shimmerHighlightColor

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "Shopping Messages",
                                style: Get.textTheme.titleSmall?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                    color: MyColors.shimmerHighlightColor
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Obx(
                                () => Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.orange, // Change to your desired color
                                  width: 2.0, // Change to your desired width
                                ),
                              ),
                              child: Text(
                                '${controller.messages.value}',
                                style: Get.textTheme.titleLarge?.copyWith(
                                    color: MyColors.shimmerHighlightColor

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                "Family Notification",
                                style: Get.textTheme.titleSmall?.copyWith(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                    color: MyColors.shimmerHighlightColor
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Obx(
                                () => Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.orange, // Change to your desired color
                                  width: 2.0, // Change to your desired width
                                ),
                              ),
                              child: Text(
                                '${controller.notifications.value}',
                                style: Get.textTheme.titleLarge?.copyWith(
                                  color: MyColors.shimmerHighlightColor
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: "${controller.greeting} ",
                  style: Get.textTheme.titleSmall,
                  children: [
                    TextSpan(
                      text: "Dear ",
                      style: Get.textTheme.titleSmall,
                    ),
                    TextSpan(
                      text: '${controller.userName} ${controller.userLastName}',
                      style: Get.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.calenderScreen);
                  },
                  child: Container(
                    height: Get.height,
                    padding: const EdgeInsets.only(left: 10, top: 6, bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        ListView(
                          physics: ScrollPhysics(),
                          children: [
                            Text('Family Upcoming Events',
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white ,
                                )),
                            Obx(
                              () => ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.upcomingEvents.length > 2 ? 2 : controller.upcomingEvents.length,
                                itemBuilder: (context, index) {
                                  final event = controller.upcomingEvents[index];
                                  return ListTile(
                                    dense: true,
                                    minLeadingWidth: 6,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                                    minVerticalPadding: 0.0,
                                    horizontalTitleGap: 8,
                                    leading: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.orange,
                                      child: Text(
                                        '${index + 1}',
                                        style: Get.textTheme.titleSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      event["title"] ?? '',
                                      maxLines: 1,
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color: MyColors.shimmerHighlightColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text(
                                      event["date"]!,
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color: MyColors.shimmerHighlightColor,
                                          fontSize: 10
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 6,
                          bottom: 6,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.event_available_outlined,
                                  color: Colors.deepOrangeAccent, size: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.taskScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, top: 6, bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        ListView(
                          children: [
                            Text(
                              'Family Recently Tasks',
                              style: Get.textTheme.titleMedium?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white ,
                              ),
                            ),
                            Obx(
                              () => ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.recentlyTask.length > 2
                                    ? 2
                                    : controller.recentlyTask.length,
                                itemBuilder: (context, index) {
                                  final event = controller.recentlyTask[index];
                                  return ListTile(
                                    minLeadingWidth: 6,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                                    minVerticalPadding: 0.0,
                                    horizontalTitleGap: 8,
                                    leading: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.orange,
                                      child: Text(
                                        '${index + 1}',
                                        style: Get.textTheme.titleSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      event["title"] ?? '',
                                      maxLines: 1,
                                      style:
                                          Get.textTheme.titleSmall?.copyWith(
                                        color: MyColors.shimmerHighlightColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text(
                                      event["date"]!,
                                      style:
                                          Get.textTheme.titleSmall?.copyWith(
                                        color: MyColors.shimmerHighlightColor,
                                            fontSize: 10
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 6,
                          bottom: 6,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.task,
                                  color: Colors.purple, size: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.notificationScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, top: 6, bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        ListView(
                          children: [
                            Text(
                              'Family Members',
                              style: Get.textTheme.titleMedium?.copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white ,
                              ),
                            ),
                            Obx(
                              () => ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.familyMembers.length > 2
                                    ? 2
                                    : controller.familyMembers.length,
                                itemBuilder: (context, index) {
                                  final member = controller.familyMembers[index];
                                  return ListTile(
                                    minLeadingWidth: 6,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                                    minVerticalPadding: 0.0, // Reduce vertical padding inside ListTile
                                    horizontalTitleGap: 8,
                                    leading: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.orange,
                                      child: Text(
                                        '${index + 1}',
                                        style: Get.textTheme.titleSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${member["firstName"] ?? ''} ${member["lastName"] ?? ''}",
                                      maxLines: 1,
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color: MyColors.shimmerHighlightColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text(
                                      member["email"] ?? '',
                                      maxLines: 1,
                                      style: Get.textTheme.titleSmall?.copyWith(
                                          color: MyColors.shimmerHighlightColor,
                                          fontSize: 10,

                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 6,
                          bottom: 6,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.message,
                                  color: Colors.red, size: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(AppRoutes.sharedShoppingListScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, top: 6, bottom: 2),
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        ListView(

                          children: [
                            Text('Family Shopping List',
                                style: Get.textTheme.titleMedium?.copyWith(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white ,
                                )),
                            Obx(
                              () => ListView.builder(
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.recentlyShopping.length > 2
                                    ? 2
                                    : controller.recentlyShopping.length,
                                itemBuilder: (context, index) {
                                  final event = controller.recentlyShopping[index];
                                  return ListTile(
                                    minLeadingWidth: 6,
                                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                                    minVerticalPadding: 0.0,
                                    horizontalTitleGap: 8,
                                    leading: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.orange,
                                      child: Text(
                                        '${index + 1}',
                                        style: Get.textTheme.titleSmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                     event["title"] ?? '',
                                      maxLines: 1,
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color: MyColors.shimmerHighlightColor,
                                          fontSize: 12,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    subtitle: Text(
                                      event["description"] ??'',
                                      style: Get.textTheme.titleSmall?.copyWith(
                                        color: MyColors.shimmerHighlightColor,
                                        fontSize: 10
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 6,
                          bottom: 6,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(Icons.shopping_cart_outlined, color: Colors.green, size: 30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Divider(thickness: 5),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 34,
              ),
              child: Column(
                children: [
                  Text(
                    "Copyrights Ⓒ NTU Family App,\nNational Textile University\n"
                    "All rights are reserved.\n",
                    style: Get.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: 60,
                      width: 60,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
