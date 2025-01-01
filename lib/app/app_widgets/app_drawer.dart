import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../app_styles/app_constant_file/app_colors.dart';
import '../app_styles/app_constant_file/app_constant.dart';
import '../app_styles/app_constant_file/app_images.dart';
import '../routes/app_routes.dart';
import '../screens/home/home_controller.dart';
import '../services/app_perferences.dart';
import 'app_dialog_confirmation_alert.dart';
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              color: MyColors.primaryColor,
            ),
            padding: const EdgeInsets.only(
              bottom: 16,
              top: 6,
              right: 8,
              left: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 0,
                  child: Image.asset(
                    MyImages.logo,
                    height: 40,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                       CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: controller.userImage.isNotEmpty
                            ? NetworkImage(controller.userImage)
                            : null,
                        child: controller.userImage.isEmpty
                            ? const Icon(
                          Icons.person,
                          color: Colors.grey,
                        )
                            : null,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(right: 16),
                          height: 65,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${controller.userName}${controller.userLastName}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Get.textTheme.titleSmall?.copyWith(
                                  color: MyColors.shimmerHighlightColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                controller.userEmail,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Get.textTheme.titleSmall?.copyWith(
                                  color: MyColors.shimmerHighlightColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_box_sharp),
            title: const Text('About Us'),
            onTap: () {
              Get.toNamed(AppRoutes.aboutScreen);
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Get.back();
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.event_available_outlined),
            title: const Text('Events'),
            onTap: () {
              Get.toNamed(AppRoutes.calenderScreen);
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.task),
            title: const Text('task'),
            onTap: () {
              Get.toNamed(AppRoutes.taskScreen);
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
          ),
          const Divider(),

          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('Message'),
            onTap: () {
              Get.toNamed(AppRoutes.sharedShoppingListScreen);
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification'),
            onTap: () {
              Get.toNamed(AppRoutes.notificationScreen);
            },
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.login_outlined),
            title: const Text('Logout'),
            onTap: () => ConfirmationAlert.showDialog(
              title:"Logout Confirmation",
              description:"Are you sure you want to log out of this app?",
              onConfirm: () {
                bool isEnabled = Get.find<Preferences>().getBool(Keys.userPassword) ?? false;

                if (!isEnabled) {
                  Get.find<Preferences>().logout();
                }
                Get.offAllNamed(AppRoutes.loginScreen);
              },
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              size: 16,
            ),
          ),
          const Divider(),

        ],
      ),

    );
  }
}