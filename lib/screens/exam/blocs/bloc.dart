export 'package:provider/provider.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/bloc.dart' as base;
import 'package:mobile_exam/core/extensions/common.dart';
import 'package:mobile_exam/core/extensions/map.dart';
import 'package:mobile_exam/core/services/server.dart';
import 'package:mobile_exam/screens/exam/blocs/counter_bloc.dart';
import 'package:mobile_exam/screens/exam/blocs/counter_event.dart';

import '../views/main.dart' as main_view;
import '../views/loading.dart' as loading_view;
import '../views/error.dart' as error_view;

extension Extension on BuildContext {
  Bloc get bloc => read<Bloc>();
}

class Bloc extends base.Bloc {
  Bloc(BuildContext context)
      : super(loading_view.ViewState(), context: context);

  @override
  Future init() async {
    final arg = context.arguments;
    final data = arg?.tryGet("data");
    final service = context.server;

    await service.accessKey; // just creating a loading state

    if (data == null || data["status_code"] == 503) {
      emit(error_view.ViewState());
      return;
    }

    emit(main_view.ViewState());
  }

  Future addToCount() async {
    final service = context.server;
    final counterBloc = context.read<CounterBloc>();

    final count = await service.addToCount(1);
    counterBloc.add(CounterChanged(count));
  }
}
