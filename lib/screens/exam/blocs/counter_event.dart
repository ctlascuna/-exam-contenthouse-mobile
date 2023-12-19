abstract class CounterEvent {}

class CounterChanged extends CounterEvent {
  final int count;

  CounterChanged(this.count);
}
