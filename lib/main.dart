import 'package:flutter/material.dart';
import 'app/app.dart';
import 'package:get/get.dart';

import 'app/pages/mesas/mesas_controller.dart';


void main() {
  Get.put(MesaPageController());


  runApp(BillbreakerAdminDashboard());
}