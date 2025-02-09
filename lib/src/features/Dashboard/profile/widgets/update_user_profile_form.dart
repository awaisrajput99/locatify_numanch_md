import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateUserProfileForm extends StatelessWidget {
  const UpdateUserProfileForm({
    super.key,

  });



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                prefixIcon: const Icon(Icons.person_outline_outlined),
                labelText: "Full Name",
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                prefixIcon: const Icon(Icons.email_outlined),
                labelText: "Email Address",
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                prefixIcon: const Icon(Icons.numbers_outlined),
                labelText: "Phone Number",
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                prefixIcon: const Icon(Icons.fingerprint_outlined),
                labelText: "Create Password",
              ),
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50)),
                prefixIcon: const Icon(Icons.fingerprint_outlined),
                labelText: "Confirm Password",
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: BorderSide.none,
                        backgroundColor: Colors.black),
                    onPressed: () {
                      Get.toNamed("/updateUserProfile");
                    },
                    child: const Text("Update",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontFamily: 'roboro')))),
            SizedBox(
              height: size.height * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: const TextSpan(
                      text: "Joined ",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          text: "12/08/2022",
                        )
                      ]),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: const StadiumBorder(),
                        side: BorderSide.none),
                    onPressed: () {},
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'roboto'),
                    ))
              ],
            )
          ],
        ));
  }
}
