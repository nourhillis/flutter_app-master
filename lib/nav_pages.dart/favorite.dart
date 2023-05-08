import 'package:flutter/material.dart';

import '../widget/realisable_text.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.favorite,
            size: 200.0,
            color: Colors.deepPurpleAccent,
          ),
          AppText(
            text: "Favorite",
            size: 20,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
