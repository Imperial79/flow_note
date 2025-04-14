import 'package:firebase_core/firebase_core.dart';
import 'package:flow_note/Helper/hive_config.dart';
import 'package:flow_note/Helper/route_config.dart';
import 'package:flow_note/Resources/commons.dart';
import 'package:flow_note/Resources/theme.dart';
import 'package:flow_note/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveConfig.init();
  systemColors();
  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeConfig = ref.read(routeProvider);
    return MaterialApp.router(
      title: "Flow Note",
      theme: kTheme(context),
      debugShowCheckedModeBanner: false,
      routerConfig: routeConfig,
    );
  }
}
