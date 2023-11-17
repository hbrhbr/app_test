import 'package:app_test/util/dimensions.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 70, width: 70,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
