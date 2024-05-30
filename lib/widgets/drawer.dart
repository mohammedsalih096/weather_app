import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controllers/theme_controller.dart';
import 'package:task1/history.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();

    return Drawer(
      backgroundColor: themeController.isDarkMode.value
          ? Color(0xff303030)
          : Color(0xffB0BCC8),
      child: Obx(() {
        return ListView(
          children: [
            GestureDetector(
              onTap: () => Get.to(() => HistoryPage()),
              child: ListTile(
                leading: Icon(
                  Icons.history,
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                ),
                title: Text(
                  "History",
                  style: TextStyle(
                    color: themeController.isDarkMode.value
                        ? Colors.white
                        : Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                "DarkMode",
                style: TextStyle(
                  color: themeController.isDarkMode.value
                      ? Colors.white
                      : Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              leading: Icon(
                Icons.dark_mode_outlined,
                color: themeController.isDarkMode.value
                    ? Colors.white
                    : Colors.black,
              ),
              trailing: Switch(
                value: themeController.isDarkMode.value,
                onChanged: (value) {
                  themeController.toggleTheme();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
