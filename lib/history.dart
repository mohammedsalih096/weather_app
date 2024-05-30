import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task1/controllers/theme_controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find();
    return Obx(() {
      bool isDarkMode = themeController.isDarkMode.value;
      return Scaffold(
          backgroundColor: isDarkMode ? Color(0xff303030) : Colors.white,
          appBar: AppBar(
            backgroundColor: isDarkMode ? Color(0xff303030) : Color(0xffB0BCC8),
            iconTheme: IconThemeData(
              color: Color(0xffFFCA2D),
            ),
            title: Text(
              "History",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color(0xffFFCA2D),
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                        ),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 73,
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? Color(0xff23282B)
                                  : Color(0xffB0BCC8),
                              borderRadius: BorderRadius.circular(26),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "Wednesday",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: isDarkMode
                                          ? Color(0xffFFFFFF)
                                          : Color(0xff245B82)),
                                ),
                                Text("India",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: isDarkMode
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff245B82))),
                                Text("8.37 AM",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: isDarkMode
                                            ? Color(0xffFFFFFF)
                                            : Color(0xff245B82))),
                              ],
                            )),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 5,
                      ),
                  itemCount: 7),
            ),
          ));
    });
  }
}
