import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/bloc/whack_event.dart';
import 'package:woof_route/widgets/settings_button.dart';
import 'package:woof_route/widgets/whack_buttons.dart';

import 'settings/game_settings.dart';
import 'settings/sound_settings.dart';
import 'whack_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/mole_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/quacker.json',
                height: 250,
                width: 250,
              ),
              Text(
                'Quack-a-Duck',
                style: TextStyle(
                  fontFamily: 'Pixel',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                'by Gab',
                style: TextStyle(
                  fontFamily: 'Pixel',
                  fontSize: 10,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              WhackButtons(
                onPressed: () {
                  // Trigger game start event and navigate to main screen
                  context.read<WhackBloc>().add(WhackOnStart());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WhackScreen(),
                    ),
                  );
                },
                content: 'PLAY',
                color: Colors.blueGrey.shade900,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SettingsButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder:
                            (_) => GameSettingsDialog(
                              backgroundImage: AssetImage(
                                'assets/images/mole_background.png',
                              ),
                              lives: 3,
                              timerSeconds: 30,
                              onBackgroundChanged: (image) {
                                context.read<WhackBloc>().add(
                                  SetBackground(image),
                                );
                              },
                              onLivesChanged: (lives) {
                                context.read<WhackBloc>().add(
                                  SetInitialLives(lives),
                                );
                              },
                              onTimerChanged: (time) {
                                // context.read<WhackBloc>().add(
                                //   SetInitialTimer(seconds),
                                // );
                              },
                            ),
                      );
                    },
                    icon: Icons.settings,
                    color: Colors.blueGrey.shade900,
                  ),
                  SizedBox(width: 20),
                  SettingsButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return SettingsDialog(
                            volume: 1.0,
                            isOn: true,
                            onVolumeChanged: (value) {
                              // Handle volume change logic here
                            },
                          );
                        },
                      );
                    },
                    icon: Icons.volume_up,
                    color: Colors.blueGrey.shade900,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
