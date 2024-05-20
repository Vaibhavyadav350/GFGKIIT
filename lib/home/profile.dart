import 'package:flutter/material.dart';

import '../components/vycontainers.dart';
import '../components/widget/appbarbox.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ProfilePage extends StatelessWidget {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          AppBarBox(heading: "   Profile"),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  SizedBox(height: 20),
            
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image Section
                      Center(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage('assets/images/cat.png'),
                            ),
                            Positioned(
                              bottom: -10,
                              right: -10,
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
            
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Center(
                        child: ListTile(
                          leading: Icon(Icons.person, color: Colors.green),
                          title: Text('Vaibhav Yadav', style: TextStyle(color: Colors.green)),
                          subtitle: Text('21052123@kiit.ac.in', style: TextStyle(color: Colors.green)),
                          onTap: () {
                            _showEditBottomSheet(context, 'Name', 'John Doe');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
            
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
            
                      Text(
                        'Interests and Preferences',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ListTile(
                        leading: Icon(Icons.category, color: Colors.green),
                        title: Text('Programming Languages', style: TextStyle(color: Colors.green)),
                        subtitle: Text('Click to write', style: TextStyle(color: Colors.green)),
                        onTap: () {
                          _showEditBottomSheet(context, 'Interests', 'Java, Python, JavaScript');
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.book, color: Colors.green),
                        title: Text('Preferred Topics', style: TextStyle(color: Colors.green)),
                        subtitle: Text('click to write ', style: TextStyle(color: Colors.green)),
                        onTap: () {
                          _showEditBottomSheet(context, 'Preferred Topics', 'Machine Learning, Web Development');
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
            
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Activity History',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
            
                    ],
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
            
                        VaibhavContainerBig(
                          height: height / 4.5,
                          width: width * 0.8,
                          title: "Relaython",
                          description: "Joined our annual hackathon event!",
                          image: AssetImage("assets/images/relay.png"),
                        ),
                        VaibhavContainerBig(
                          height: height / 4.5,
                          width: width * 0.8,
                          title: "Amazon Wow",
                          description: "Women in Tech Talk",
                          image: AssetImage("assets/images/wow.png"),
                        ),
            
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Achievements and Badges',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      // Add widgets to display user's achievements and badges
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
            
                            VaibhavContainerBig(
                              height: height / 4.5,
                              width: width * 0.8,
                              title: "Upcoming Hackathon",
                              description: "Join our annual hackathon event!",
                              image: AssetImage("assets/images/certi.png"),
                            ),
                            VaibhavContainerBig(
                              height: height / 4.5,
                              width: width * 0.8,
                              title: "Tech Talk Series",
                              description: "Learn from industry experts!",
                              image: AssetImage("assets/images/goodie.png"),
                            ),
                          ],
                        ),
                      ),
            
                    ],
                  ),
                  SizedBox(height: 20),
            
                  // Logout Button
                  SizedBox(height: 20),
                  ElevatedButton(
            
                    onPressed: () async { await FirebaseAuth.instance.signOut();
            
                    },
                    child: Text('Logout',),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context, String title, String initialValue) {
    TextEditingController controller = TextEditingController(text: initialValue);

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit $title',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: 'New $title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // Implement save functionality
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
