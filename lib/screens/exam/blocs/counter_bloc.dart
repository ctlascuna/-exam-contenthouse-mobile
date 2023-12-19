import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_exam/screens/exam/blocs/counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterChanged>(onCounterChanged);
  }

  void onCounterChanged(
    CounterChanged event,
    Emitter<int> emit,
  ) {
    emit(state + 1);
  }
}
