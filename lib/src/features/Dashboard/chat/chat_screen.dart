
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/constants/colors.dart';
import 'package:locatify/src/features/Dashboard/chat/controllers/chat_appbar_controller.dart';
import 'package:locatify/src/features/Dashboard/chat/controllers/chat_user_card_controller.dart';
import 'package:locatify/src/features/Dashboard/chat/widgets/chat_user_card.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';
import 'package:locatify/src/repositey/user_repository/user_repository.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserRepository());
    final chatAppbarController = Get.put(ChatAppbarController());

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: StreamBuilder<List<MdUserModel>>(
        stream: userController.getAllUsersStream(), // ✅ Using the new stream
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
            case ConnectionState.none:
              return Center(
                child: CircularProgressIndicator(
                  color: MdAppColors.mdPrimaryColor,
                ),
              );

            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<MdUserModel> list = snapshot.data!;
                return Obx( () => ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: chatAppbarController.isSearching.value
                      ? chatAppbarController.searchList.length
                      : chatAppbarController.list.length, // ✅ Corrected
                  itemBuilder: (context, index) {
                    final user = chatAppbarController.isSearching.value
                        ? chatAppbarController.searchList[index]
                        : chatAppbarController.list[index];
                    return ChatUserCard(user: user);
                  },
                ),);


              } else {
                return Center(child: Text("No users found"));
              }

            default:
              return Text("Error: ${snapshot.connectionState}");
          }
        },
      ),
    );
  }
}
