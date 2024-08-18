import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:memory/providers/database_provider.dart';
import 'package:memory/utils/colors.dart';
import 'package:memory/utils/helpers.dart';
import 'package:memory/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class AddMemory extends StatefulWidget {
  const AddMemory({super.key});

  @override
  State<AddMemory> createState() => _AddMemoryState();
}

class _AddMemoryState extends State<AddMemory> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            LucideIcons.chevronLeft,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }
                          databaseProvider.memoryModel.title = titleController.text;
                          databaseProvider.memoryModel.description = descriptionController.text;
                          databaseProvider.memoryModel.date = dateController.text;
                          databaseProvider.memoryModel.time = timeController.text;
                          databaseProvider.addMemoryToDatabase().then(
                            (value) {
                              titleController.clear();
                              descriptionController.clear();
                              dateController.clear();
                              timeController.clear();
                              Navigator.of(context).pop();
                            },
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            LucideIcons.check,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(30.0),
                  CustomTextField(
                    controller: titleController,
                    labelText: "Memory title",
                    validator: (value) {
                      if (value == "") {
                        return "Please enter memory title";
                      }
                      return null;
                    },
                  ),
                  const Gap(30.0),
                  CustomTextField(
                    controller: descriptionController,
                    labelText: "Memory description",
                    validator: (value) {
                      if (value == "") {
                        return "Please enter memory description";
                      }
                      return null;
                    },
                  ),
                  const Gap(30.0),
                  CustomTextField(
                    isRead: true,
                    controller: dateController,
                    labelText: 'Memory date',
                    validator: (value) {
                      if (value == "") {
                        return "Please enter memory date";
                      }
                      return null;
                    },
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          dateController.text = Helpers.dateFormatter(date);
                        });
                      }
                    },
                  ),
                  const Gap(30),
                  CustomTextField(
                    isRead: true,
                    controller: timeController,
                    labelText: 'Memory Time',
                    validator: (value) {
                      if (value == "") {
                        return "Please enter memory time";
                      }
                      return null;
                    },
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() {
                          timeController.text = Helpers.timeToString(time);
                        });
                      }
                    },
                  ),
                  const Gap(30.0),
                  ElevatedButton(
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      databaseProvider.memoryModel.title = titleController.text;
                      databaseProvider.memoryModel.description = descriptionController.text;
                      databaseProvider.memoryModel.date = dateController.text;
                      databaseProvider.memoryModel.time = timeController.text;
                      databaseProvider.addMemoryToDatabase().then(
                        (value) {
                          titleController.clear();
                          descriptionController.clear();
                          dateController.clear();
                          timeController.clear();
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppColors.primaryColor,
                      ),
                      minimumSize: MaterialStatePropertyAll(Size(300.0, 50.0)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Add Memory",
                        style: TextStyle(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
