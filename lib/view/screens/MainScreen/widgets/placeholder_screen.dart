import 'package:flutter/material.dart';

class PlaceHolderScreen extends StatefulWidget {
  const PlaceHolderScreen({Key? key}) : super(key: key);

  @override
  State<PlaceHolderScreen> createState() => _PlaceHolderScreenState();
}

class _PlaceHolderScreenState extends State<PlaceHolderScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
          "Coming Soon",
      ),
    );
  }
}
