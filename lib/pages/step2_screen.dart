import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:god/config/images.dart';
import 'package:god/pages/step3_screen.dart';
import 'package:god/pages/widget/SpanTitle.dart';
import 'package:god/pages/widget/commonText.dart';
import 'package:god/pages/widget/savebutton.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class Step2Screen extends StatefulWidget {
  const Step2Screen({super.key});

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(
            bottom: 15,
            left: 15,
            right: 15,
          ),
          child: SwipeableButtonView(
            buttonText: "Next",
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
            onFinish: () {
              // Ensure that the navigation happens only after the state change
              if (isCompleted) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Step3Screen(),
                  ),
                );
              }
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 15, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpanTitle(
                  mainTitle: "Here’s the Word of",
                  subTitle: " God for You",
                ),
                CommonText(text: "The user selects their issue "),
                SizedBox(
                  height: size * 0.04,
                ),
                CommonText(
                  text:
                      '''Verse \nPsalm 34:18:\n“The Lord is close to the brokenhearted and saves those who are crushed in spirit.”\n\nExplanation:\nIt reminds us that God is not distant during our lowest moments; instead, He draws near to provide support and healing. Being “brokenhearted” or “crushed in spirit” reflects deep emotional pain, and this verse assures us that God sees our struggles and actively works to restore us. It encourages seeking His presence as a source of strength and hope, even when life feels overwhelming.''',
                ),
                SizedBox(
                  height: size * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SaveButton(text: "Save Verse"),
                    SaveButton(text: "Share Verse"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
