import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for clipboard functionality
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
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  double _currentPosition = 0.0;
  double _duration = 1.0;
  bool _isBuffering = false;

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
    _audioPlayer = AudioPlayer();

    // Listen for position updates
    _audioPlayer.positionStream.listen((position) {
      if (mounted) {
        setState(() {
          _currentPosition = position.inMilliseconds.toDouble();
        });
      }
    });

    // Listen for duration updates
    _audioPlayer.durationStream.listen((duration) {
      if (mounted) {
        setState(() {
          _duration = duration?.inMilliseconds.toDouble() ?? 1.0;
        });
      }
    });

    // Listen for playback events (including buffering)
    _audioPlayer.playbackEventStream.listen((event) {
      setState(() {
        _isBuffering = event.processingState == ProcessingState.buffering;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void togglePlayPause() async {
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      try {
        await _audioPlayer.setUrl(audioUrl); // Load the audio
        await _audioPlayer.play(); // Then play the audio
      } catch (e) {
        if (kDebugMode) {
          print('Error playing audio: $e');
        }
        setState(() {
          isPlaying = false; // Revert to paused state on error
        });
      }
    } else {
      await _audioPlayer.pause();
    }
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
    final position = Duration(milliseconds: value.toInt());
    _audioPlayer.seek(position);
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 15,
          top: size * 0.05, // Adjust padding based on screen size
        ),
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
                  _isBuffering
                      ? CircularProgressIndicator()
                      : Slider(
                          min: 0.0,
                          max: _duration,
                          value: _currentPosition,
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
