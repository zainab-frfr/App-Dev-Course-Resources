import 'dart:async';

import 'package:equatable/equatable.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_timer_code_lab/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int _duration = 60;
  final Ticker _ticker;

  StreamSubscription<int>? _tickerSubscription;
  /*
  In Flutter (and Dart in general), a StreamSubscription is an object that represents an active subscription to a Stream. 
  When you listen to a Stream (using .listen()), 
  a StreamSubscription is returned, allowing you to interact with the stream’s data as it arrives over time.
  */
  
  TimerBloc(this._ticker): super(const TimerInitial(_duration)){
    on<TimerStarted>(_onStarted); // event handlers
    on<_TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {  // to cancel the stream when the bloc  is closed
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration)); // if receives a timer started event then push a timer run in progress state with the start duration
    _tickerSubscription?.cancel(); //if there was already an open _tickerSubscription we need to cancel it to deallocate the memory. 
    _tickerSubscription = _ticker // ticker.tick stream daydee to the stream declared here. 
        .tick(ticks: event.duration)
        .listen((duration) => add(_TimerTicked(duration: duration))); // on every tick (duration one second defined in ticker class) we add a timer ticked event.
        
        // event bitha rahay hain this is not a state
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.duration > 0
          ? TimerRunInProgress(event.duration) // emit timer run in progress event if time still left 
          : const TimerRunComplete(), // warna emit timer run complete 
    );
  }
  
  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription?.pause();
      emit(TimerRunPause(state.duration));
    }
  }

  void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(_duration));
  }

}