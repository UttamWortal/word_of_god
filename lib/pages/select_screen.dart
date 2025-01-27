import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:god/config/images.dart';
import 'package:god/pages/step2_screen.dart';
import 'package:god/pages/widget/commonText.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(
          bottom: 15,
          left: 15,
          right: 15,
        ),
        child: SwipeableButtonView(
          buttonText: "Let’s start",
          buttonWidget: const Icon(
            Icons.arrow_forward_ios,
            color: Colors.black,
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
          onFinish: () {
            // Ensure that the navigation happens only after the state change
            if (isCompleted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Step2Screen(),
                ),
              );
            }
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 15, top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Select Your ",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Issue",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            commonText(text: "The user selects one issue they are facing"),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Image.asset(AssetsImages.welecome),
            SizedBox(height: screenHeight * 0.02),
            Text(
              "Select one issue",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: textLightGrey,
              ),
            ),
            // Dropdown
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: commonText(
                    text: "Select One Type",
                  ),
                  items: const [
                    DropdownMenuItem(
                        value: "Depression", child: Text("Depression")),
                    DropdownMenuItem(value: "Anxiety", child: Text("Anxiety")),
                    DropdownMenuItem(
                        value: "Loneliness", child: Text("Loneliness")),
                    DropdownMenuItem(value: "Anger", child: Text("Anger")),
                  ],
                  onChanged: (value) {
                    // Handle dropdown selection
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
