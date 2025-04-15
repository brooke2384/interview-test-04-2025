import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Image(
                  image: AssetImage('assets/logo.png'),
                  height: 30,
                ),
                Text(
                  "Movie Reviews",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Get.toNamed("/login"),
                  child: Text(
                    "Login",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
