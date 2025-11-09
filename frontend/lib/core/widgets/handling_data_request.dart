import 'package:flutter/material.dart';

enum RequestState { loading, success, error, empty }

class HandlingDataRequest extends StatelessWidget {
  final RequestState requestState;
  final Widget widget;
  final String? errorMessage;

  const HandlingDataRequest({
    Key? key,
    required this.requestState,
    required this.widget,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (requestState) {
      case RequestState.loading:
        return const Center(child: CircularProgressIndicator());
      case RequestState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                errorMessage ?? "Error",
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      case RequestState.empty:
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text("No Data", style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      case RequestState.success:
        return widget;
    }
  }
}
