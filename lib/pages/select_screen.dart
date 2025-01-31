import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:god/config/images.dart';
import 'package:god/pages/step2_screen.dart';
import 'package:god/pages/widget/SpanTitle.dart';
import 'package:god/pages/widget/commonText.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  bool isCompleted = false;
  String? selectedValue;

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
            buttonText: "Let’s start",
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
                    builder: (context) => Step2Screen(),
                  ),
                );
              }
            },
          ),
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 15, top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SpanTitle(
                mainTitle: "Select Your",
                subTitle: " Issue",
              ),
              CommonText(text: "The user selects one issue they are facing"),
              SizedBox(
                height: size * 0.02,
              ),
              Image.asset(AssetsImages.welecome),

              SizedBox(height: size * 0.02),
              Text(
                "Select one issue",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                  color: brown,
                ),
              ),

              // Dropdown
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: textBorder,
                    width: 1.2,
                  ),
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedValue,
                    hint: Text(
                      "Select One Type",
                      style: TextStyle(
                        color: Color(0XFF6B6B6B),
                        fontSize: 18.6,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "Depression",
                        child: Text(
                          "Depression",
                          style: GoogleFonts.montserrat(
                            color: dropdownText,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.33,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Anxiety",
                        child: Text(
                          "Anxiety",
                          style: GoogleFonts.montserrat(
                            color: dropdownText,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.33,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Loneliness ",
                        child: Text(
                          "Loneliness",
                          style: GoogleFonts.montserrat(
                            color: dropdownText,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.33,
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: "Anger",
                        child: Text(
                          "Anger",
                          style: GoogleFonts.montserrat(
                            color: dropdownText,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.33,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                    icon: Image.asset(
                      AssetsImages.dropdown,
                      height: 10,
                    ),
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
