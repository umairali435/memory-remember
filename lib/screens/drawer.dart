import 'package:flutter/material.dart';
import 'package:memory/utils/colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    void launchURL(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw 'Could not launch $url';
      }
    }

    void launchWebsite() {
      const url = 'https://memoryrememberapp.blogspot.com/2024/08/memory-remember-privacy-policy.html';
      launchURL(url);
    }

    void launchAppStore() {
      Share.share("""You can find Edad Age Mate https://apps.apple.com/store/apps/details?id=com.sulemam.edad""");
    }

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.5,
      child: SafeArea(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset(
                "assets/app_icon.png",
                width: 50.0,
                height: 50.0,
              ),
            ),
            const Text(
              "Memory Remember",
              style: TextStyle(
                fontSize: 24.0,
                color: AppColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(),
            ListTile(
              onTap: () {
                launchWebsite();
              },
              leading: const Icon(
                Icons.privacy_tip,
                color: AppColors.primaryColor,
              ),
              title: const Text("Privacy Policy"),
            ),
            ListTile(
              onTap: () {
                launchAppStore();
              },
              leading: const Icon(
                Icons.share,
                color: AppColors.primaryColor,
              ),
              title: const Text("Share App"),
            ),
          ],
        ),
      ),
    );
  }
}
