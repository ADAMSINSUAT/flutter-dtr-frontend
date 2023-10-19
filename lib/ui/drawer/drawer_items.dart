import 'package:flutter/material.dart';
import 'package:mobile_dtr_prototype/ui/drawer/drawer_item.dart';

final itemsIP = [
  DrawerItem(title: 'Update IP Address', icon: Icons.wifi),
];

final itemsDTR = [
  DrawerItem(title: 'Daily Time Record', icon: Icons.schedule),
  DrawerItem(title: 'Area of Assignments', icon: Icons.location_on),
  DrawerItem(title: 'Leave', icon: Icons.event_busy),
  DrawerItem(title: 'Office Order', icon: Icons.moving),
  DrawerItem(title: 'Compensatory Time Off', icon: Icons.perm_contact_calendar),
];

final itemsUserSettings = [
  DrawerItem(title: 'Reset DTR Password', icon: Icons.lock),
  DrawerItem(title: 'Software Update', icon: Icons.system_update_alt),
  DrawerItem(title: 'Logout', icon: Icons.logout),
];
