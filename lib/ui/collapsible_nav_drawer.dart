import 'package:flutter/material.dart';
import 'package:mobile_dtr_prototype/constants/navigation_provider.dart';
import 'package:mobile_dtr_prototype/constants/routes.dart';
import 'package:provider/provider.dart';

import 'drawer/drawer_item.dart';
import 'drawer/drawer_items.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;

    return Container(
      // ignore: dead_code
      width: isCollapsed ? MediaQuery.of(context).size.width * 0.2 : null,
      child: Drawer(
          child: Container(
              color: Color(0xFF1a2f45),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 24).add(safeArea),
                      width: double.infinity,
                      color: const Color.fromARGB(43, 255, 255, 255),
                      child: buildHeader(isCollapsed, context)),
                  const SizedBox(height: 24),
                  buildList(items: navItems, isCollapsed: isCollapsed),
                  Spacer(),
                  buildCollapseIcon(context, isCollapsed),
                  const SizedBox(height: 12),
                ],
              ))),
    );
  }
}

Widget buildList({
  required bool isCollapsed,
  required List<DrawerItem> items,
}) =>
    ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return buildMenuItem(
          isCollapsed: isCollapsed,
          text: item.title,
          icon: item.icon,
          onClicked: () {},
        );
      },
    );

Widget buildMenuItem({
  required bool isCollapsed,
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final leading = Icon(icon, color: color);

  return ListTile(
      leading: leading,
      title: Text(text, style: TextStyle(color: color, fontSize: 16)));
}

Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
  final double size = 52;
  final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
  final alignment = isCollapsed ? Alignment.center : Alignment.centerRight;
  final margin = EdgeInsets.only(right: 16);
  final width = isCollapsed ? double.infinity : size;

  return Container(
    alignment: alignment,
    margin: margin,
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        child: Container(
            width: width,
            height: size,
            child: Icon(
              icon,
              color: Colors.white,
            )),
        onTap: () {
          final provider =
              Provider.of<NavigationProvider>(context, listen: false);

          provider.toggleIsCollapsed();
        },
      ),
    ),
  );
}

Widget buildHeader(bool isCollapsed, BuildContext context) => isCollapsed
    ? Card(
        child: Container(
          height: 80,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.50),
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('images/DOH_icon.jpg'))),
        ),
      )
    : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  height: 80,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.50),
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage('images/DOH_icon.jpg'))),
                ),
              ),
            ],
          ),
          Text(
            "Department of Health \n Mobile Daily Time Record System",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: Text("Logout", style: TextStyle(color: Colors.white)))
        ],
      );
