import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/constants/colors.dart';
import 'package:locatify/src/features/Dashboard/chat/controllers/chat_appbar_controller.dart';
import 'package:locatify/src/features/Dashboard/controllers/dashboard_controller.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    final chatAppbarController = Get.put(ChatAppbarController());

    return Obx(() => GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: (){
          if(chatAppbarController.isSearching.value){
            chatAppbarController.toggleSearch();
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Scaffold(
              // 🔥 Wrap the entire Scaffold in Obx to rebuild UI
              appBar:
                  _buildAppBar(controller.currentIndex.value, chatAppbarController),
              body: PageView(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.changeIndex(index);
                },
                children: controller.screens,
              ),
              bottomNavigationBar: CurvedNavigationBar(
                backgroundColor: Colors.white,
                buttonBackgroundColor: MdAppColors.mdPrimaryColor,
                color: MdAppColors.mdPrimaryColor,
                animationDuration: const Duration(milliseconds: 300),
                items: controller.navItems,
                index: controller.currentIndex.value,
                onTap: (index) {
                  controller.changeIndex(index);
                  controller.pageController.jumpToPage(index);
                },
              ),
            ),
      ),
    ));
  }

  // 🔥 Function to return AppBar based on the selected page
  PreferredSizeWidget _buildAppBar(
      int currentIndex, ChatAppbarController chatAppbarConterller) {
    if (currentIndex == 1) {
      // Custom AppBar for Chat Screen
      return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MdAppColors.mdPrimaryColor,
        title: chatAppbarConterller.isSearching.value? SizedBox(
          width: 300,
          height: 45,
          child: TextFormField(
            onChanged: (value) {
              chatAppbarConterller.searchUsers(value); // ✅ Call search function
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: "Name, email ....",
              hintStyle: TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: TextStyle(color: Colors.black54),
            autofocus: true,
          ),
        ) :Text(
          "LOCATIFY",
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 35, color: Colors.white),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                chatAppbarConterller.toggleSearch();
              },
              icon: chatAppbarConterller.isSearching.value
                  ? Icon(
                      CupertinoIcons.clear_circled,
                      color: Colors.white,
                      size: 35,
                    )
                  : Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
          ),
        ],
      );
    } else if (currentIndex == 2) {
      return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: MdAppColors.mdPrimaryColor,
        title: const Text(
          "LOCATIFY",
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 35, color: Colors.white),
        ),
      );
    } else {
      return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed('/notifications'),
            icon: const Icon(
              Icons.notifications_active_outlined,
              size: 35,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: MdAppColors.mdPrimaryColor,
        title: const Text(
          "LOCATIFY",
          style: TextStyle(
              fontFamily: "Roboto", fontSize: 35, color: Colors.white),
        ),
      );
      // Default AppBar for other screens
    }
  }
}
