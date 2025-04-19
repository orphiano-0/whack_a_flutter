import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                      // borderRadius: BorderRadius.circular(15),
                      // boxShadow: const [
                      //   BoxShadow(
                      //     color: Colors.black26,
                      //     blurRadius: 4,
                      //     offset: Offset(2, 2),
                      //   ),
                      // ],
                    ),
                    child: Center(
                      child:
                          isMoleUp
                              ? Image.asset(
                                'assets/images/mole.png',
                                width: 100,
                                height: 100,
                              )
                              : Image.asset(
                                'assets/images/hole.png',
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
