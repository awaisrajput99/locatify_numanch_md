import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class ProfileMenu extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final Color? textColor;
  final bool endIcon;
  final IconData icon;
  const ProfileMenu({
    required this.title,
    required this.ontap,
    this.textColor = Colors.black,
    this.endIcon = true,
    this.icon = Icons.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: MdAppColors.mdButtonColor.withOpacity(0.3),
          ),
          child: Icon(icon,size: 24,color: Colors.black,),
        ),
        title: Text(title,style: TextStyle(fontSize: 16, color: textColor),),
        trailing:  endIcon? Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.black.withOpacity(0.1),
          ),
          child:const Icon(Icons.arrow_forward_ios_outlined,size: 15,color: Colors.grey,),
        ): null,
      ),
    );
  }
}