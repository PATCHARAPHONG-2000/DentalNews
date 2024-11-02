import 'package:dentalnews/Home/chat_bot/chat_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ChatScreen();
                  },
                ),
              );
            },
            child: Text('Chat Bot'),
          ),
          const SizedBox(
            height: 16,
          ),
          FilledButton(
            onPressed: () {},
            child: const Text('Text to image'),
          ),
        ],
      )),
    );
  }
}
