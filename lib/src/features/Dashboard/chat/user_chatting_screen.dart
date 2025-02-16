import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/features/Dashboard/chat/controllers/chat_screen_input_controller.dart';
import 'package:locatify/src/features/Dashboard/chat/widgets/chat_screen_appbar.dart';
import 'package:locatify/src/features/Dashboard/chat/widgets/chat_screen_input_field.dart';
import 'package:locatify/src/features/Dashboard/chat/widgets/chat_screen_message_list.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';

import '../../../constants/colors.dart';

class UserChattingScreen extends StatelessWidget {
  final MdUserModel user;

  const UserChattingScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final chattingscreenController = Get.put(ChatScreenInputController());// Extracted controller
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus(); // Hide keyboard on tap
        Future.delayed(Duration(milliseconds: 100), () {
          chattingscreenController.setIsTyping(false);
        });
      },
      child: Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: ChatScreenAppbar(user: user),
          backgroundColor: MdAppColors.mdPrimaryColor,
        ), // ✅ Using extracted App Bar
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Expanded(child: ChatScreenMessageList()), // ✅ Using extracted Chat Messages
              ChatScreenInputField(), // ✅ Using extracted Input Field
            ],
          ),
        ),
      ),
    );
  }
}