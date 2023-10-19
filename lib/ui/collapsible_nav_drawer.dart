import 'package:flutter/material.dart';
import 'package:mobile_dtr_prototype/constants/navigation_provider.dart';
import 'package:mobile_dtr_prototype/constants/routes.dart';
import 'package:provider/provider.dart';

import 'drawer/drawer_item.dart';
import 'drawer/drawer_items.dart';

import 'dart:developer' as devtools show log;

final padding = EdgeInsets.only(right: 10);

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final safeArea =
        EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top);

    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;

    return Container(
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
                  buildList(items: itemsIP, isCollapsed: isCollapsed),
                  Divider(),
                  buildList(
                      indexOffset: itemsIP.length,
                      items: itemsDTR,
                      isCollapsed: isCollapsed),
                  Divider(),
                  buildList(
                      indexOffset: itemsIP.length + itemsDTR.length,
                      items: itemsUserSettings,
                      isCollapsed: isCollapsed),
                  Divider(),
                  buildCollapseIcon(context, isCollapsed),
                ],
              ))),
    );
  }
}

//This is the widget for displaying the different items and icons in the nav-drawer
Widget buildList({
  required bool isCollapsed,
  required List<DrawerItem> items,
  int indexOffset = 0,
}) =>
    ListView.separated(
      padding: padding,
      shrinkWrap: true,
      primary: false,
      itemCount: items.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 2,
      ),
      itemBuilder: (context, index) {
        final item = items[index];

        return buildMenuItem(
          isCollapsed: isCollapsed,
          text: item.title,
          icon: item.icon,
          onClicked: () => selectItem(context, indexOffset + index),
        );
      },
    );

void selectItem(BuildContext context, int index) {
  final route = "/";
  final navigateTo = (page) =>
      Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);

  Navigator.of(context).pop();

  switch (index) {
    case 8:
      navigateTo(loginRoute);
      break;
  }
}

//This is the widget for the nav-drawer items
Widget buildMenuItem({
  required bool isCollapsed,
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  final color = Colors.white;
  final leading = Icon(icon, color: color);

  return Material(
    color: Colors.transparent,
    child: isCollapsed
        ? ListTile(
            title: leading,
            onTap: onClicked,
          )
        : ListTile(
            leading: leading,
            title: Text(text, style: TextStyle(color: color, fontSize: 16)),
            onTap: onClicked,
          ),
  );
}

//This is the icon for changing the width of the collapsible nav-drawer
Widget buildCollapseIcon(BuildContext context, bool isCollapsed) {
  final double size = 52;
  final icon = isCollapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios;
  final alignment = isCollapsed ? Alignment.bottomRight : Alignment.centerRight;
  final margin = isCollapsed
      ? EdgeInsets.only(right: 16, top: 15)
      : EdgeInsets.only(right: 16);
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

//This is the header of the nav-drawer
Widget buildHeader(bool isCollapsed, BuildContext context) => isCollapsed
    ? Card(
        child: Container(
          height: 80,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.50),
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('images/DOH_icon.jpg'))
                  ),
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
          // TextButton(
          //     onPressed: () {
          //       Navigator.of(context)
          //           .pushNamedAndRemoveUntil(loginRoute, (route) => false);
          //     },
          //     child: Text("Logout", style: TextStyle(color: Colors.white)))
        ],
      );
