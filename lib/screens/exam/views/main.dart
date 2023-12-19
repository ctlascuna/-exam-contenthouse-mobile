import 'package:flutter/material.dart';
import 'package:mobile_exam/core/app/view.dart' as base;
import 'package:mobile_exam/screens/exam/blocs/bloc.dart';
import 'package:mobile_exam/screens/exam/blocs/counter_bloc.dart';

class ViewState extends base.ViewState {
  @override
  Widget content(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final data = args?["data"];

    return Padding(
      padding: const EdgeInsets.all(35.0),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          SizedBox(
            height: 300.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30.0),
              child: Image.network(
                data?["image"],
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object error,
                    StackTrace? stackTrace) {
                  return Image.asset(
                    'assets/images/oops.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(data["message"]),
          const SizedBox(height: 20),
          StreamBuilder<int>(
            stream: context.read<CounterBloc>().stream,
            builder: (context, snapshot) {
              return ElevatedButton(
                onPressed: () async {
                  context.read<Bloc>().addToCount();
                },
                child: Text('Count: ${snapshot.data ?? (data?["count"])}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
