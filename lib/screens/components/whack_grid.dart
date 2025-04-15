import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/bloc/whack_event.dart';
import 'package:woof_route/bloc/whack_state.dart';

class WhackGrid extends StatefulWidget {
  const WhackGrid({super.key,});

  @override
  State<WhackGrid> createState() => _WhackGridState();
}

class _WhackGridState extends State<WhackGrid> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _playClickSound() async {
    await _audioPlayer.play(AssetSource('assets/audio/smash.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WhackBloc, WhackState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(12),
            child: AspectRatio(
              aspectRatio: 1,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1,
                ),
                itemCount: 16,
                itemBuilder: (context, moleIndex) {
                  final isMoleUp = state.molePosition[moleIndex];
                  return GestureDetector(
                    onTap: () => context.read<WhackBloc>().add(MoleWhacked(moleIndex),),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                        isMoleUp ? Colors.red : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child:
                        isMoleUp
                            ? Image.asset(
                          'assets/images/rodent.png',
                          width: 80,
                          height: 80,
                        )
                            : Image.asset(
                          'assets/images/pixelated_chicken.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
    );
  }
}
