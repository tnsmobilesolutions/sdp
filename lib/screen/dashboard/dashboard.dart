import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/dashboard/dashboardBody.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const LeadingImage(),
        automaticallyImplyLeading: false,
        title: const Text(
          'ସମ୍ମିଳନୀ ଦିନିକିଆ ପାଳି',
        ),
        actions: const [ActionWidget()],
      ),
      body: SafeArea(
        child: DashboardBody(),
      ),
    );
  }
}
