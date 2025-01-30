import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:god/config/images.dart';
import 'package:god/pages/select_screen.dart';
import 'package:god/pages/widget/commonText.dart';
import 'package:god/pages/widget/commonTextfield.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class Step5Screen extends StatefulWidget {
  const Step5Screen({super.key});

  @override
  State<Step5Screen> createState() => _Step5ScreenState();
}

class _Step5ScreenState extends State<Step5Screen> {
  bool isCompleted = false;
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          bottom: 15,
          left: 15,
          right: 15,
        ),
        child: SwipeableButtonView(
          buttonText: "Request Callback",
          buttonWidget: Image.asset(
            AssetsImages.arrow,
            height: 15,
            color: black,
          ),
          activeColor: Colors.black,
          isFinished: isCompleted,
          onWaitingProcess: () {
            Future.delayed(const Duration(seconds: 1), () {
              setState(() {
                isCompleted = true;
              });
            });
          },
          onFinish: () async {
            // Check if the name field is empty
            if (nameController.text.isEmpty) {
              setState(() {
                isCompleted = false;
              });
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Name is required!"),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Proceed to the next screen
            if (isCompleted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectScreen(),
                ),
              );
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: "Request for a",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: " Callback ",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    TextSpan(
                      text: "(Optional)",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              CommonText(
                text:
                    "If users feel they need further guidance, they can request a callback.",
              ),
              SizedBox(height: size * 0.05),
              CommonTextfieldName(
                text: "Name (required):",
              ),
              SizedBox(
                height: size * 0.06,
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: size * 0.01),
              const CommonTextfieldName(text: "Address:"),
              SizedBox(
                height: size * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: size * 0.01),
              CommonTextfieldName(text: "Country:"),
              SizedBox(
                height: size * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: size * 0.01),
              CommonTextfieldName(text: "State:"),
              SizedBox(
                height: size * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: size * 0.01),
              CommonTextfieldName(text: "City:"),
              SizedBox(
                height: size * 0.06,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
