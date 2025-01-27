import 'package:flutter/material.dart';
import 'package:word_of_god/config/color.dart';
import 'package:word_of_god/config/images.dart';
import 'package:word_of_god/pages/step4_screen.dart';
import 'package:word_of_god/pages/widget/commonText.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class Step3Screen extends StatefulWidget {
  const Step3Screen({super.key});

  @override
  State<Step3Screen> createState() => _Step3ScreenState();
}

class _Step3ScreenState extends State<Step3Screen> {
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
          buttonText: "Next",
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
                  builder: (context) => Step4Screen(),
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
                    text: "Let’s ",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "Pray ",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: "Together  ",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "The user selects their issue ",
              style: TextStyle(
                fontSize: 16,
                color: textLightGrey,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            commonText(
              text:
                  '''I feel overwhelmed and heavy-hearted. Please bring me Your peace, strength, and comfort. Help me trust in Your love and guidance, even in this darkness. Restore my hope and fill me with Your light. Thank You for being my refuge.''',
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    // Add copy functionality here
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.copy,
                        color: Colors.black,
                        size: 12,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "Copy Text",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: textLightGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Image.asset(AssetsImages.voice),
            SizedBox(
              height: screenHeight * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
