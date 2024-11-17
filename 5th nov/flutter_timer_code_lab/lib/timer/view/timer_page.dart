import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_code_lab/ticker.dart';
import 'package:flutter_timer_code_lab/timer/bloc/timer_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TimerBloc(const Ticker()),
      child: const TimerView(),
    );
  }
}

class TimerView extends StatelessWidget {
  const TimerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Timer')),
      body: const Stack(
        children: [
          Background(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 100.0),
                child: Center(child: TimerText()),
              ),
              Actions(),
            ],
          ),
        ],
      ),
    );
  }
}

class TimerText extends StatelessWidget {
  // rebuilt on every tick
  const TimerText({super.key});
  @override
  Widget build(BuildContext context) {
    final duration = context.select((TimerBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).floor().toString().padLeft(2, '0');
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.displayLarge,
    );
  }
}

/*
Actions uses context.read<TimerBloc>() to access the TimerBloc instance and returns different 
FloatingActionButtons based on the current state of the TimerBloc. 
Each of the FloatingActionButtons adds an event in its onPressed callback to notify the TimerBloc.
*/
class Actions extends StatelessWidget {
  const Actions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) =>
          prev.runtimeType != state.runtimeType, // will only be rebuilt when previous state is different to current state
      /*
      we don’t want the Actions widget to be rebuilt on every tick because that would be inefficient.
      Instead, we only want Actions to rebuild if the runtimeType of the TimerState changes (TimerInitial => TimerRunInProgress, 
      TimerRunInProgress => TimerRunPause, etc…).
      */
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              /*
              the ...  (spread) operator in Dart is used to “spread” or unpack a list of items into another list.
              In this case, ...switch (state) { ... } spreads the resulting list of widgets from the switch expression 
              directly into the children list of the Row.
              */
              TimerInitial() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () => context
                        .read<TimerBloc>()
                        .add(TimerStarted(duration: state.duration)), //event bitha ruhay ho
                  ),
                ],
              TimerRunInProgress() => [
                  FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerPaused()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],
              TimerRunPause() => [
                  FloatingActionButton(
                    child: const Icon(Icons.play_arrow),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerResumed()),
                  ),
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ],
              TimerRunComplete() => [
                  FloatingActionButton(
                    child: const Icon(Icons.replay),
                    onPressed: () =>
                        context.read<TimerBloc>().add(const TimerReset()),
                  ),
                ]
            }
          ],
        );
      },
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue.shade50,
            Colors.blue.shade500,
          ],
        ),
      ),
    );
  }
}
