import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:god/config/color.dart';
import 'package:god/config/images.dart';
import 'package:god/pages/step4_screen.dart';
import 'package:god/pages/widget/commonText.dart';
import 'package:god/pages/widget/savebutton.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';
import 'package:just_audio/just_audio.dart';

class Step3Screen extends StatefulWidget {
  const Step3Screen({super.key});

  @override
  State<Step3Screen> createState() => _Step3ScreenState();
}

class _Step3ScreenState extends State<Step3Screen> {
  bool isCompleted = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  double _currentPosition = 0.0;
  double _duration = 1.0;

  final String audioUrl =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";

  final String prayerText = '''
I feel overwhelmed and heavy-hearted. Please bring me Your peace, strength, and comfort. 
Help me trust in Your love and guidance, even in this darkness. Restore my hope and fill me with Your light. 
Thank You for being my refuge.
''';

  @override
  void initState() {
    super.initState();
    _setupAudio();
  }

  void _setupAudio() async {
    try {
      await _audioPlayer.setUrl(audioUrl);

      _audioPlayer.durationStream.listen((duration) {
        if (duration != null && mounted) {
          setState(() {
            _duration = duration.inMilliseconds.toDouble();
          });
        }
      });

      _audioPlayer.positionStream.listen((position) {
        if (mounted) {
          setState(() {
            _currentPosition =
                position.inMilliseconds.toDouble().clamp(0, _duration);
          });
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error loading audio: $e");
      }
    }
  }

  void togglePlayPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: prayerText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Text copied to clipboard!"),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onSliderChanged(double value) {
    _audioPlayer.seek(Duration(milliseconds: value.toInt()));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
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
            if (isCompleted) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Step4Screen()),
              );
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 15, top: size * 0.05),
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
                        color: Colors.black),
                  ),
                  TextSpan(
                    text: "Pray ",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue),
                  ),
                  TextSpan(
                    text: "Together",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            SizedBox(height: size * 0.01),
            CommonText(text: "The user selects their issue"),

            SizedBox(height: size * 0.1),
            CommonText(text: prayerText),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: copyToClipboard,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.copy, color: Colors.black, size: 14),
                    SizedBox(width: 4),
                    Text(
                      "Copy Text",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: lightGrey,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: size * 0.05),

            // Optimized Audio Player
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
                  Slider(
                    min: 0.0,
                    max:
                        _duration > 1.0 ? _duration : 1.0, // Ensuring valid max
                    value: _currentPosition.clamp(
                        0.0, _duration), // Preventing out-of-range error
                    onChanged: _onSliderChanged,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add save voice functionality
                    },
                    child: SaveButton(text: "Save voice"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
