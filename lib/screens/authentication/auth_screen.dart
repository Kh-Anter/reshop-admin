import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsivedashboard/constants.dart';
import 'package:responsivedashboard/models/validations.dart';
import 'package:responsivedashboard/provider/authentication_controller.dart';
import 'package:responsivedashboard/responsive/desktop_body.dart';
import 'package:responsivedashboard/responsive/mobile_body.dart';
import 'package:responsivedashboard/responsive/responsive_layout.dart';
import 'package:responsivedashboard/responsive/tablet_body.dart';
import 'package:responsivedashboard/widgets/mytextfield.dart';
import '../../size_config.dart';

class AuthenticationScreen extends StatefulWidget {
  static const routeName = "/forgetPassword";
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final globalKey = GlobalKey<FormState>();
  String emailError = "";
  String passError = "";
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthenticationController>(context);
    // var mainProvider = Provider.of<MainController>(context);
    // mainProvider.init();
    bool isDesktop = SizeConfig.isDesktop(context);
    return Scaffold(
        backgroundColor: myTextFieldBackgroundColor,
        body: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: SizedBox(
                      width: 150,
                      height: 150,
                      child: Image.asset("web/images/splash.png"))),
              Container(
                  width: isDesktop ? 400 : 300,
                  height: isDesktop ? 400 : 300,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 10),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Admin panel login"),
                          const SizedBox(height: 20),
                          Form(
                            key: globalKey,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyTextField(
                                    labelText: "Email",
                                    type: TextInputType.name,
                                    controller: authProvider.emailCtr,
                                    parentState: setState,
                                    validator: (value) {
                                      if (!Validations.validateEmail(value)) {
                                        setState(() =>
                                            emailError = "Invalid Email!");
                                      }
                                    },
                                  ),
                                  if (emailError.isNotEmpty) error(emailError),
                                  MyTextField(
                                    labelText: "Password",
                                    controller: authProvider.passCtrl,
                                    parentState: setState,
                                    validator: (value) {
                                      setState(() => passError =
                                          Validations.validatePasswrd(
                                              password: value));
                                    },
                                  ),
                                  if (passError.isNotEmpty) error(passError),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "Forgot Password ?",
                                        style: TextStyle(color: Colors.black),
                                      )),
                                ]),
                          ),
                          const SizedBox(height: 20),
                          signInBtn(authProvider, context)
                        ]),
                  )),
            ],
          ),
        )));
  }

  Widget signInBtn(authProvider, BuildContext ctx) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: () async {
          FocusScope.of(ctx).unfocus();
          setState(() {
            passError = "";
            emailError = "";
            globalKey.currentState?.validate();
            if (emailError == "" && passError == "") {
              authProvider.signIn().then((value) {
                if (value == null) {
                  Navigator.of(ctx).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (ctx) => ResponsiveLayout(
                              mobileBody: const MobileScaffold(),
                              tabletBody: const TabletScaffold(),
                              desktopBody: const DesktopScaffold())),
                      (route) => false);
                } else {
                  print(value);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(value)));
                  print("--------------------------hhhh----------");
                }
              });
            }
          });
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(primaryColor),
            shape: null),
        child: const Text("Sign in"),
      ),
      //  ),
    );
  }

  Widget error(txt) {
    return Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          txt,
          style: const TextStyle(color: primaryColor),
        ));
  }
}
