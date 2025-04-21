import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:woof_route/bloc/whack_bloc.dart';
import 'package:woof_route/bloc/whack_event.dart';
import 'package:woof_route/bloc/whack_state.dart';

class WhackGrid extends StatefulWidget {
  const WhackGrid({super.key});

  @override
  State<WhackGrid> createState() => _WhackGridState();
}

class _WhackGridState extends State<WhackGrid> {

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
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 10,
                childAspectRatio: 1,
              ),
              itemCount: 9,
              itemBuilder: (context, moleIndex) {
                final isMoleUp = state.molePosition[moleIndex];
                return GestureDetector(
                  onTap: () {
                    context.read<WhackBloc>().add(MoleWhacked(moleIndex));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child:
                          isMoleUp
                              ? Lottie.asset(
                                'assets/lottie/quacker.json',
                                width: 150,
                                height: 150,
                              )
                              : Image.asset(
                                'assets/images/cracked.png',
                                width: 100,
                                height: 100,
                              ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
