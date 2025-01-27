import 'package:flutter/material.dart';
import 'package:word_of_god/config/color.dart';
import 'package:word_of_god/pages/step5_screen.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class Step4Screen extends StatefulWidget {
  const Step4Screen({super.key});

  @override
  State<Step4Screen> createState() => _Step4ScreenState();
}

class _Step4ScreenState extends State<Step4Screen> {
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
                  builder: (context) => Step5Screen(),
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
                    text: "Activities ",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: "to Overcome",
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
              "User selects their actionable activities related to the selected issueissue.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: textLightGrey,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${index + 1}. ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: textLightGrey,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.",
                            style: TextStyle(
                              fontSize: 16,
                              color: textLightGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
