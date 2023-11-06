import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double screenHeight = 0;
  double screenWidth = 0;
  Color primary = Color.fromARGB(253, 2, 253, 27);
  String birth = "Date of birth";

  File? image;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  void pickUploadProfilePic() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
      imageQuality: 90,
    );

    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                pickUploadProfilePic();
              },
              child: Container(
                margin: const EdgeInsets.only(top: 80, bottom: 24),
                height: 120,
                width: 120,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primary,
                ),
                child: Center(
                  child: image == null
                      ? Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 80,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(image!),
                        ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Employee ",
                style: const TextStyle(
                  fontFamily: "NexaBold",
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 24,),
            textField("First Name", "First name", firstNameController),
            textField("Last Name", "Last name", lastNameController),
            GestureDetector(
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: primary,
                          secondary: primary,
                          onSecondary: Colors.white,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            primary: primary,
                          ),
                        ),
                        textTheme: const TextTheme(
                          headline4: TextStyle(
                            fontFamily: "NexaBold",
                          ),
                          overline: TextStyle(
                            fontFamily: "NexaBold",
                          ),
                          button: TextStyle(
                            fontFamily: "NexaBold",
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                ).then((value) {
                    if (value != null) { // Periksa apakah value tidak null
                      setState(() {
                        birth = DateFormat("MM/dd/yyyy").format(value);
                    });
                  }
                });
              },
              child: image == null
                  ? Text(
                      birth,
                      style: const TextStyle(
                        color: Colors.black54,
                        fontFamily: "NexaBold",
                        fontSize: 16,
                      ),
                    )
                  : field("Date of Birth", birth),
            ),
            textField("Address", "Address", addressController),
            GestureDetector(
              onTap: () async {
                String firstName = firstNameController.text;
                String lastName = lastNameController.text;
                String birthDate = birth;
                String address = addressController.text;

                showSnackBar("Profile saved");
              },
              child: Container(
                height: kToolbarHeight,
                width: screenWidth,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: primary,
                ),
                child: const Center(
                  child: Text(
                    "SAVE",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "NexaBold",
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget field(String title, String text) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "NexaBold",
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          height: kToolbarHeight,
          width: screenWidth,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.only(left: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: Colors.black54,
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.black54,
                fontFamily: "NexaBold",
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget textField(
      String title, String hint, TextEditingController controller) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: "NexaBold",
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: TextFormField(
            controller: controller,
            cursorColor: Colors.black54,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                color: Colors.black54,
                fontFamily: "NexaBold",
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
        ),
      ),
    );
  }
}
