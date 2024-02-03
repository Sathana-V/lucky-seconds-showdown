import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Counter {
  Widget luckyContainer(BuildContext context, WidgetRef ref) {
    return Container(
      width: 100,
      height: 100,
      child: (Image.asset('assets/counter/count0.png')),
    );
  }
}
