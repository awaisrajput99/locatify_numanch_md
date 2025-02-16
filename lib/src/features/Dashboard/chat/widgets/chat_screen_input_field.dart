import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:locatify/src/constants/colors.dart';
import 'package:locatify/src/features/Dashboard/chat/controllers/chat_screen_input_controller.dart';

class ChatScreenInputField extends StatelessWidget {
  ChatScreenInputField({super.key});

  final controller = Get.put(ChatScreenInputController());
  final TextEditingController textController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    focusNode.addListener(() {
      controller.setIsTyping(focusNode.hasFocus);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  children: [
                    // Hide Icons & Expand TextField When Focused
                    Obx(() => controller.isTyping.value
                        ? SizedBox.shrink() // Hide icons
                        : AnimatedOpacity(
                      opacity: controller.isTyping.value ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 300),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.emoji_emotions,
                                color: MdAppColors.mdButtonColor,
                                size: 35),
                          ),
                          SizedBox(width: 5), // Space between icons
                        ],
                      ),
                    )),

                    // Text Field (Expands to full width when focused)
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        minLines: 1, // Start with 1 line
                        maxLines: 3, // Expand up to 3 lines
                        focusNode: focusNode,
                        cursorColor: Colors.blueAccent,
                        decoration: InputDecoration(
                          fillColor: Colors.black54.withOpacity(0.1),
                          filled: true,
                          hintText: "Type something...",
                          hintStyle: TextStyle(color: Colors.blueAccent),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(
                            color: Colors.blueAccent, fontFamily: 'roboto'),
                        scrollPhysics: AlwaysScrollableScrollPhysics(), // Enables scrolling
                      ),
                    ),

                    // Hide Image & Camera Icons When Typing
                    Obx(() => controller.isTyping.value
                        ? SizedBox.shrink()
                        : AnimatedOpacity(
                      opacity: controller.isTyping.value ? 0.0 : 1.0,
                      duration: Duration(milliseconds: 300),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.image,
                                color: MdAppColors.mdButtonColor,
                                size: 35),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.camera_alt,
                                color: MdAppColors.mdButtonColor,
                                size: 35),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
          ),

          // Send Button (Always Visible)
          MaterialButton(
            minWidth: 0,
            onPressed: () {},
            padding: EdgeInsets.all(10),
            shape: CircleBorder(),
            // color: Colors.white,
            child: Icon(Icons.send, color: Colors.blueAccent, size: 35),
          ),
        ],
      ),
    );
  }
}