import 'package:flutter/material.dart';
import 'package:god/config/color.dart';
import 'package:god/config/images.dart';
import 'package:god/pages/step4_screen.dart';
import 'package:god/pages/widget/commonText.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:just_audio/just_audio.dart';

class Step3Screen extends StatefulWidget {
  const Step3Screen({super.key});

  @override
  State<Step3Screen> createState() => _Step3ScreenState();
}

class _Step3ScreenState extends State<Step3Screen> {
  bool isCompleted = false;
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      try {
        await _audioPlayer.setAsset(
            'assets/audio/sample.ogg'); // Ensure this path is correct and matches your pubspec.yaml
        await _audioPlayer.play();
      } catch (e) {
        print('Error playing audio: $e');
      }
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
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
              text: const TextSpan(
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
            const Text(
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
                    children: const [
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
            // Audio Player Section
            Center(
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause_circle : Icons.play_circle,
                      size: 64,
                      color: Colors.blue,
                    ),
                    onPressed: togglePlayPause,
                  ),
                  Container(
                    width: screenHeight * 0.2,
                    height: screenHeight * 0.05,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: textBlue,
                    ),
                    child: Center(
                      child: Text(
                        "Save voice",
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
            ),
          ],
        ),
      ),
    );
  }
}
