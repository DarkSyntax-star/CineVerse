import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ios_preview/flutter_ios_preview.dart';
import 'app.dart';

void main() {
  runApp(
    const ProviderScope(
        child: MyApp(),
      ),
    ),
}