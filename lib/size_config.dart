import 'package:flutter/material.dart';

class SizeConfig {
  // BuildContext ctx;
  // SizeConfig(this.ctx);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 850 &&
      MediaQuery.of(context).size.width > 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;
}
