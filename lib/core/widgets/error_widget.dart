import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String errorMsg;
  final VoidCallback onRetry;

  const MyErrorWidget({
    super.key,
    required this.onRetry,
    required this.errorMsg,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMsg == '{"detail":"connection_error"}'
                ? "Internet not connected, please check your connection."
                : errorMsg == '{"detail":"server_error"}'
                ? "There is a problem with the server. Please try again later."
                : errorMsg ?? "An unknown error occurred.",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
