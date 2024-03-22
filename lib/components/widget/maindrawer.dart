import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return
      Drawer(
      child: ListView(
        children:  [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Column()
          ),
          ListTile(

            leading: Icon(Icons.account_balance_outlined,color: Colors.green,),
            title: Text("About"),
          ),
          ListTile(
            leading: Icon(Icons.photo,color: Colors.green,),
            title: Text("Gallery"),
          ),
          ListTile(
            leading: Icon(Icons.event_available,color: Colors.green,),
            title: Text("Past Events"),
          ),
          ListTile(
            leading: Icon(Icons.group,color: Colors.green,),
            title: Text("Members"),
          ), ListTile(
            leading: Icon(Icons.people_outlined,color: Colors.green,),
            title: Text("Leads"),
          ),
          ListTile(
            leading: Icon(Icons.work,color: Colors.green,),
            title: Text("Projects"),
          )
        ],
      ),
    );
  }
}