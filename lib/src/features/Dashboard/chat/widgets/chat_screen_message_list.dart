import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/repositey/message_repository/message_repository.dart';

class ChatScreenMessageList extends StatelessWidget {
  const ChatScreenMessageList({super.key});

  @override
  Widget build(BuildContext context) {
  final messageRespository = Get.put(MessageRepository());
    return StreamBuilder(
    stream: messageRespository.getAllMessages(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text("Error fetching messages"));
      } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
        return Center(child: Text("No messages yet"));
      }

      // Extract messages from snapshot correctly
      final List<Map<String, dynamic>> messages = snapshot.data!.docs
          .map((doc) => doc.data()) // Convert each document to a Map<String, dynamic>
          .toList();

      print("message: ${jsonEncode(messages)}");
      return ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index]["message"] ?? "No message";
          final sentAt = messages[index]["sent"] ?? "Unknown time";

          return ListTile(
            title: Text(message),
            subtitle: Text("Sent at: $sentAt"),
          );
        },
      );
    },
  );
  }
}