import 'package:flutter/material.dart';
import 'package:word_of_god/config/color.dart';
import 'package:word_of_god/pages/step3_screen.dart';
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
          padding: const EdgeInsets.only(left: 20, right: 15, top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Here’s the Word of ",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "God for You",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
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
                height: screenHeight * 0.03,
              ),
              Text(
                '''Verse \nPsalm 34:18:\n“The Lord is close to the brokenhearted and saves those who are crushed in spirit.”\n\nExplanation:\nIt reminds us that God is not distant during our lowest moments; instead, He draws near to provide support and healing. Being “brokenhearted” or “crushed in spirit” reflects deep emotional pain, and this verse assures us that God sees our struggles and actively works to restore us. It encourages seeking His presence as a source of strength and hope, even when life feels overwhelming.''',
                style: TextStyle(
                  fontSize: 16,
                  color: textLightGrey,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenHeight * 0.2,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: textBlue,
                    ),
                    child: Center(
                      child: Text(
                        "Save Verse",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: screenHeight * 0.2,
                    height: screenHeight * 0.07,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: textBlue,
                    ),
                    child: Center(
                      child: Text(
                        "Share Verse",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: screenHeight * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
