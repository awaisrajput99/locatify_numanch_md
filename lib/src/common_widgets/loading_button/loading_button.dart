import 'package:flutter/material.dart';
import 'package:locatify/src/constants/colors.dart';
class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        children: [
          CircularProgressIndicator(
            color: MdAppColors.mdPrimaryColor,
          ),
          SizedBox(
            width: 10,
          ),
          Text("loading..."),
        ],
      ),
    );
  }
}
