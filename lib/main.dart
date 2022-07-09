import 'package:automobileservice/assets/custom_theme.dart';
import 'package:automobileservice/controller/data_controller.dart';
import 'package:automobileservice/firebase_options.dart';
import 'package:automobileservice/route/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

// key = AIzaSyDzVd6TjPaTheUBOs4hFD1jouKTxOTkhA0
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(const AutoMobileService());
}

class AutoMobileService extends StatelessWidget {
  const AutoMobileService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataController()),
      ],
      child: MaterialApp(
        routes: routes,
        debugShowCheckedModeBanner: false,
        theme: customTheme,
      ),
    );
  }
}
