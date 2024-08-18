import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:memory/providers/database_provider.dart';
import 'package:memory/screens/add_memory.dart';
import 'package:memory/screens/drawer.dart';
import 'package:memory/utils/colors.dart';
import 'package:memory/utils/helpers.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            color: AppColors.primaryColor,
            width: double.infinity,
            child: SafeArea(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: const CircleAvatar(
                          backgroundColor: AppColors.whiteColor,
                          child: Icon(
                            LucideIcons.menu,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const AddMemory(),
                            ),
                          );
                        },
                        child: const CircleAvatar(
                          backgroundColor: AppColors.whiteColor,
                          child: Icon(
                            LucideIcons.plus,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    "assets/app_icon.png",
                    height: 130.0,
                    width: 150.0,
                  ),
                  Text(
                    "Save every Memory",
                    style: GoogleFonts.cabin(
                      color: AppColors.whiteColor,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Your Memories",
                    style: TextStyle(
                      color: AppColors.blackColor,
                      fontSize: 28.0,
                    ),
                  ),
                  database.allAges.isEmpty
                      ? Column(
                          children: [
                            Image.asset("assets/memory_image.png"),
                            const Gap(30.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => const AddMemory(),
                                  ),
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
                        )
                      : Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: CarouselSlider(
                              items: database.allAges
                                  .map((memory) => Container(
                                        padding: const EdgeInsets.all(20.0),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              memory.date.toString(),
                                              style: const TextStyle(
                                                color: AppColors.whiteColor,
                                                fontSize: 32.0,
                                              ),
                                            ),
                                            Text(
                                              memory.time.toString(),
                                              style: const TextStyle(
                                                color: AppColors.whiteColor,
                                                fontSize: 22.0,
                                              ),
                                            ),
                                            Text(
                                              memory.title.toString(),
                                              style: const TextStyle(
                                                color: AppColors.whiteColor,
                                                fontSize: 42.0,
                                              ),
                                            ),
                                            const Gap(20.0),
                                            Text(
                                              memory.description.toString(),
                                              style: const TextStyle(
                                                color: AppColors.whiteColor,
                                                fontSize: 22.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                height: double.infinity,
                                autoPlay: true,
                                enlargeCenterPage: true,
                                enableInfiniteScroll: true,
                                onPageChanged: (index, reason) {},
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
