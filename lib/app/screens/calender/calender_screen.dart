import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import '../../app_widgets/custom_card_widget.dart';
import '../../routes/app_routes.dart';
import 'controllers/calender_controller.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EventController controller = Get.put(EventController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        backgroundColor: MyColors.primaryColor,
      ),
      body: Obx(() {
        if (controller.events.isEmpty) {
          return const Center(child: Text("No Data Found"));
        }

        return ListView.builder(
          itemCount: controller.events.length,
          itemBuilder: (context, index) {
            Color backgroundColor = index % 2 == 0
                ? Colors.white
                : const Color(0xffe5f7f1);
            final event = controller.events[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomCard(
                onPressed: (){
                  Get.toNamed(
                    AppRoutes.createNewEvent,
                    arguments: {
                      'id': event['id'],
                      'title': event['title'],
                      'date': event['date'],
                      'time': event['time'],
                    },
                  );
                },
                color: backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.event_available_outlined,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      event["title"]!,
                      style: Get.textTheme.titleMedium?.copyWith(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: [
                        Text(event["date"]!),
                        SizedBox(width: 6.0,),
                        Text(event["time"]!),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 40,
                      ),
                      onPressed: () {
                        controller.deleteEvent(event['id']!);
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.createNewEvent);
        },
        backgroundColor: MyColors.primaryColor,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
