// states which our timer bloc can be in 

part of 'timer_bloc.dart'; //organizes code across multiple files
/*
The sealed keyword ensures that all subclasses of TimerState are defined in the same file. 
This restricts which classes can extend TimerState, enhancing maintainability and readability.
*/

sealed class TimerState extends Equatable{ // two instances of TimerState with the same duration are considered equal, 
  const TimerState(this.duration);
  final int duration;

  @override
  List<Object> get props => [duration]; 
  //This allows Equatable to use duration for comparisons. When props is defined, 
  // Equatable will check this property to determine equality.
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

final class TimerRunPause extends TimerState {
  const TimerRunPause(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

final class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(super.duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

final class TimerRunComplete extends TimerState {
  const TimerRunComplete() : super(0);
}