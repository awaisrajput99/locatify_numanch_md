import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';

class ChatScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  final MdUserModel user;

  const ChatScreenAppbar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        InkWell(
          onTap: (){},
          child: Row(
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(CupertinoIcons.back, size: 30),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  width: 50,
                  height: 50,
                  imageUrl: user.image,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.FullName, style: TextStyle(fontSize: 22, fontFamily: 'roboto')),
                  Text('Last scene not available', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}