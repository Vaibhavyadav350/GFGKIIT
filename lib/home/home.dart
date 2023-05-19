import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GFG Kiit"),),
      drawer: Drawer(

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
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset("assets/images/gfg_logo.png",
                fit: BoxFit.cover,height: 150 ,),
              //  BottomNavigationBar(items: )
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text("We are a group of enthusiasts "
                    "trying to spread the idea of One "
                    "for All and All for One. We inspire "
                    "students to practice coding, get acquainted "
                    "with algorithms and enjoy the concepts in a"
                    " full fledged way. We are putting immense "
                    "efforts in increasing the standards of our society"
                    " by proposing new ideas for the benefit of our fellow mates"
                    " and for our growth as well.", style: TextStyle(fontSize: 25,color: Colors.lightGreen),),
              )
            ],
          ),
        ),
      ),

    );
  }
}
