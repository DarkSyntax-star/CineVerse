
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/providers/theme_provider.dart';
import 'routes/app_router.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFE50914),
          secondary: Color(0xFF221F1F),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        fontFamily: GoogleFonts.inter().fontFamily,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914),
          secondary: Color(0xFFF5F5F1),
        ),
      ),
      themeMode: themeMode,
      routerConfig: ref.watch(routerProvider),
    );
  }
}
