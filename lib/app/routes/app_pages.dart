import 'package:family_events_app/app/screens/calender/create_new_event.dart';
import 'package:family_events_app/app/screens/tasks/create_new_task.dart';
import 'package:get/get.dart';
import '../screens/about/about_screen.dart';
import '../screens/calender/calender_screen.dart';
import '../screens/forget_password/forget_password_screen.dart';
import '../screens/home/home_screen.dart';
import '../screens/introduction/app_intro_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/notifications/notification_screen.dart';
import '../screens/shopping/create_notice_board_item.dart';
import '../screens/shopping/create_shopping_list_screen.dart';
import '../screens/shopping/shared_notice_board_screen.dart';
import '../screens/shopping/shared_shopping_list_detail_screen.dart';
import '../screens/shopping/shared_shopping_list_screen.dart';
import '../screens/signup/sign_up_screen.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/tasks/task_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = <GetPage>[
    GetPage(name: AppRoutes.splash, page: () => const Splash()),
    GetPage(
      name: AppRoutes.introduction,
      page: () => const IntroScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => const Login(),
    ),
    GetPage(
      name: AppRoutes.signupScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.taskScreen,
      page: () => const TaskScreen(),
    ),
    GetPage(
      name: AppRoutes.notificationScreen,
      page: () => const NotificationScreen(),
    ),
    GetPage(
      name: AppRoutes.calenderScreen,
      page: () => const EventScreen(),
    ),
    GetPage(
      name: AppRoutes.createNewEvent,
      page: () => const CreateNewEvent(),
    ),
    GetPage(
      name: AppRoutes.createNewTask,
      page: () => const CreateNewTask(),
    ),
    GetPage(
      name: AppRoutes.sharedShoppingListScreen,
      page: () => const SharedShoppingListsScreen(),
    ),
    GetPage(
      name: AppRoutes.createShoppingList,
      page: () => const CreateShoppingListScreen(),
    ),
    GetPage(
      name: AppRoutes.shoppingListID,
      page: () => const ShoppingListDetailScreen(),
    ),
    // Implement ShoppingListDetailScreen
    GetPage(
      name: AppRoutes.sharedNoticeboard,
      page: () => const SharedNoticeboardScreen(),
    ),
    GetPage(
      name: AppRoutes.createNoticeboardItem,
      page: () => CreateNoticeboardItemScreen(),
    ),
    GetPage(
      name: AppRoutes.forgotPasswordScreen,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.aboutScreen,
      page: () => const AboutUsPage(),
    ),
  ];
}
