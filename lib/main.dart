import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsivedashboard/firebase_options.dart';
import 'package:responsivedashboard/provider/authentication_controller.dart';
import 'package:responsivedashboard/provider/page_controller.dart';
import 'package:responsivedashboard/provider/theme_provider.dart';
import 'package:responsivedashboard/responsive/desktop_body.dart';
import 'package:responsivedashboard/responsive/mobile_body.dart';
import 'package:responsivedashboard/responsive/responsive_layout.dart';
import 'package:responsivedashboard/responsive/tablet_body.dart';
import 'package:responsivedashboard/screens/authentication/auth_screen.dart';
import 'package:responsivedashboard/util/my_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => CurrentPageController()),
    ChangeNotifierProvider(create: (context) => AuthenticationController()),
    ChangeNotifierProvider(create: (_) {
      return ThemeProvider();
    })
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    MyThemes allThemes = MyThemes(ctx: context);
    return FutureBuilder(
        future: themeProvider.init(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: snapshot.data == true
                  ? allThemes.darkTheme()
                  : allThemes.lightTheme(),
              home: StreamBuilder(
                  stream: FirebaseAuth.instance
                      .authStateChanges()
                      .handleError((error) {
                    if (error is FirebaseAuthException &&
                        error.code == 'user-not-found') {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AuthenticationScreen()));
                    }
                  }),
                  builder: (context, streamSnapshot) {
                    if (FirebaseAuth.instance.currentUser == null) {
                      return const AuthenticationScreen();
                    } else {
                      return ResponsiveLayout(
                        mobileBody: const MobileScaffold(),
                        tabletBody: const TabletScaffold(),
                        desktopBody: const DesktopScaffold(),
                      );
                    }
                  }));
        });
  }
}
