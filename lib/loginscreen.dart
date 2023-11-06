import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:absensi_colmitra/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController passController = TextEditingController();

  double screenHeight = 0;
  double screenWidth = 0;

  Color primary = Color.fromARGB(253, 2, 253, 27);

  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = KeyboardVisibilityProvider.isKeyboardVisible(context);
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          isKeyboardVisible ? SizedBox(height: screenHeight / 16,) : Container(
            height: screenHeight / 3,
            width: screenWidth,
            decoration: BoxDecoration(
              color: primary,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(70),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: screenWidth / 5,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: screenHeight / 15,
              bottom: screenHeight / 20,
            ),
            child: Text(
            "Login",
              style: TextStyle(
                fontSize: screenWidth / 18,
                fontFamily: "Cabin-Bold",
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.symmetric(
              horizontal: screenWidth / 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               fieldTitle("Your E-mail"),
               customField("example@gmail.com", idController, false),
               fieldTitle("Password"),
               customField("Enter your password", passController, true),
               GestureDetector(
                onTap: () async {
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                 child: Container(
                  height: 60,
                  width: screenWidth,
                  margin: EdgeInsets.only(top: screenHeight / 40),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Text(
                      "SIGN IN",
                      style: TextStyle(
                        fontFamily: "Cabin-Bold",
                        fontSize: screenWidth / 26,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                 ),
               )
        ],
      ),
      ),
        ],
      ),
    );
  }

  Widget fieldTitle(String title) {
    return Container(
        margin: const EdgeInsets.only(bottom: 12),
        child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth / 26,
          fontFamily: "Cabin-Bold",
        ),
      ),
    );
  }

  Widget customField(String hint, TextEditingController controller, bool obscure) {
    return Container(
          width: screenWidth,
          margin: EdgeInsets.only(bottom: 12),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: screenWidth / 6,
                child:  Icon(
            Icons.person,
            color: primary,
            size: screenWidth / 15,
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: screenWidth / 12),
            child: TextFormField(
              controller: controller,
              enableSuggestions: false,
              autocorrect: false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: screenHeight / 35,
                ),
                border: InputBorder.none,
                hintText: hint,
              ),
              maxLines: 1,
              obscureText: obscure,
            ),
          ),
        )
      ],
    ),
  );
  }
}