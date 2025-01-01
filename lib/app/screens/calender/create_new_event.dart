import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_helpers/app_spacing.dart';
import '../../app_styles/app_constant_file/app_colors.dart';
import 'controllers/create_new_event_controller.dart';

class CreateNewEvent extends StatelessWidget {
  const CreateNewEvent({super.key});

  @override
  Widget build(BuildContext context) {
    final CreateNewEventController controller = Get.put(CreateNewEventController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        title: Text(controller.eventId != null ? 'Update Event' : 'Create Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              controller: controller.eventTitleController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              autofillHints: const [AutofillHints.username],
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                labelText: 'Task Title',
              ),
            ),
            otherSpacerVertically(),
            GestureDetector(
              onTap: () async {
                await controller.pickDate(controller.dateController);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: controller.dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: const InputDecoration(
                    filled: true,
                    label: Text("Date"),
                    hintText: "Date",
                    fillColor: Colors.white,
                    suffixIcon: Icon(Icons.calendar_month),
                  ),
                ),
              ),
            ),
            otherSpacerVertically(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  controller.pickTime(context, "Task Time");
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: controller.timeController,
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      filled: true,
                      labelText: "Time",
                      fillColor: Colors.white,
                      hintText: "12:00 PM",
                      suffixIcon: Icon(Icons.access_time),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: Get.width,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  controller.addOrUpdateEvent();
                },
                child: Text(controller.eventId != null ? 'Update Event' : 'Add Event'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
