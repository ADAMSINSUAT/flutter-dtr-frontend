import 'package:flutter/material.dart';
import 'package:mobile_dtr_prototype/ui/collapsible_nav_drawer.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        title: const Text('Home Page', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: (Column(
        children: [
          const SizedBox(height: 2),
          const Text("Welcome to the Home Page!")
        ],
      )),
    );
  }
}
