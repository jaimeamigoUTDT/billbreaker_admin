import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'app/app.dart';
import 'package:get/get.dart';

import 'app/pages/mesas/mesas_controller.dart';


void main() {
  Get.put(MesaPageController());
  usePathUrlStrategy();
  runApp(BillbreakerAdminDashboard());
}