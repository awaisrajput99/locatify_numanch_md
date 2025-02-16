import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:locatify/src/features/authentication/models/user_model.dart';

import '../../../../repositey/user_repository/user_repository.dart';

class ChatAppbarController extends GetxController {
  static ChatAppbarController get instance => Get.find();

  // ✅ Use RxList instead of List
  var list = <MdUserModel>[].obs;
  var searchList = <MdUserModel>[].obs;

  var isSearching = false.obs;
  var searchFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
    fetchAllUsers(); // ✅ Fetch users when controller initializes
  }

  void fetchAllUsers() {
    UserRepository().getAllUsersStream().listen((users) {
      list.assignAll(users); // ✅ Update observable list properly
    });
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchFocusNode.unfocus();
      searchList.clear(); // ✅ Clear search when exiting search mode
    }
  }

  // ✅ Proper search function
  void searchUsers(String query) {
    if (query.isEmpty) {
      searchList.clear(); // ✅ If empty, reset list
      return;
    }
    searchList.assignAll(
        list.where((user) =>
        user.FullName.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase()))
    );
  }
}