import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Icon(
              Icons.account_circle,
              color: Colors.blue[50],
              size: 96,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.dashboard),
                    title: Text('Home'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_bag),
                    title: Text('Shop'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.event),
                    title: Text('Event'),
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(
                      color: Colors.grey[400],
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logout();
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
