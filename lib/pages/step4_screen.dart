import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:god/config/images.dart';
import 'package:god/pages/step5_screen.dart';
import 'package:god/pages/widget/commonText.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    builder: (context) => Step5Screen(),
                  ),
                );
              }
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 15,
            top: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Activities ",
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: blue,
                      ),
                    ),
                    TextSpan(
                      text: "to Overcome",
                      style: GoogleFonts.montserrat(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: black,
                      ),
                    ),
                  ],
                ),
              ),
              CommonText(
                text:
                    "User selects their actionable activities related to the selected issueissue.",
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(text: "${index + 1}. "),
                          Expanded(
                            child: CommonText(
                              text:
                                  "Lorem Ipsum, giving information on its origins, as well as a random Lipsum generator.",
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
      ),
    );
  }
}
