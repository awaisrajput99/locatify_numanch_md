import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/features/Dashboard/chat/user_chatting_screen.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';

class ChatUserCard extends StatelessWidget {
  final MdUserModel user;
  const ChatUserCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        onTap: () {
          Get.to(()=> UserChattingScreen(user: user));
        },
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              width: 50,
              height: 50,
              imageUrl: user.image,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text(
            user.FullName,
            style: TextStyle(fontFamily: 'roboto', fontSize: 22),
          ),
          subtitle: Text(
            user.about,
            maxLines: 1,
          ),
          trailing: Text(
            "2:34 pm",
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
