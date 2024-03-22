import 'package:flutter/material.dart';
import 'package:gfg_kiit/admin/hackathon.dart';

import '../components/vycontainers.dart';

import '../components/widget/appbarbox.dart';
import '../domain/aiml.dart';
import '../domain/appdev.dart';
import '../domain/blockchain.dart';
import '../domain/coredev.dart';
import '../domain/gamedev.dart';
import '../domain/uiux.dart';
import '../domain/webdev.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBarBox(heading: "   Welcome"),
              Padding(

                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(
                  "Upcoming Events",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HackathonDetailsPage()),
                        );
                      },
                      child: VaibhavContainerBig(
                        height: height / 4.5,
                        width: width * 0.8,
                        title: "Upcoming Hackathon",
                        description: "Join our annual hackathon event!",
                        image: AssetImage("assets/images/hackathon_image.jpeg"),
                      ),
                    ),
                    VaibhavContainerBig(
                      height: height / 4.5,
                      width: width * 0.8,
                      title: "Tech Talk Series",
                      description: "Learn from industry experts!",
                      image: AssetImage("assets/images/techtalk.png"),
                    ),
                    VaibhavContainerBig(
                      height: height / 4.55,
                      width: width * 0.8,
                      title: "Webinar on AI",
                      description: "Discover the latest in AI technology!",
                      image: AssetImage("assets/images/ai.png"),
                    ),
                    // Add more VaibhavContainers here as needed
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(
                  "Featured Content",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VaibhavContainerBig(
                      height: height / 5,
                      width: width * 0.96,
                      title: "Programming Competition",
                      description: "Showcase your coding skills!",
                      image: AssetImage("assets/images/competi.png"),
                    ),
                    VaibhavContainerBig(
                      height: height / 5,
                      width: width * 0.96,
                      title: "Podcast Series",
                      description: "Listen to our latest tech discussions!",
                      image: AssetImage("assets/images/podcast.png"),
                    ),
                    VaibhavContainerBig(
                      height: height / 5,
                      width: width * 0.96,
                      title: "Code Challenge",
                      description: "Test your coding abilities!",
                      image: AssetImage("assets/images/codecha.png"),
                    ),

                    // Add more VaibhavContainers here as needed
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(
                  "Domains",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AppDevelopmentPage()),
                        );
                      },
                      child: VaibhavContainerSmall(
                        height: height / 4.8,
                        width: width * 0.4,
                        title: "App Development",
                        image: AssetImage("assets/images/app.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WebDevelopmentPage()),
                        );
                      },
                      child: VaibhavContainerSmall(
                        height: height / 4.8,
                        width: width * 0.4,
                        title: "Web Development",
                        image: AssetImage("assets/images/web.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BlockchainPage()),
                        );
                      },
                      child: VaibhavContainerSmall(
                        height: height / 4.8,
                        width: width * 0.4,
                        title: "Blockchain",
                        image: AssetImage("assets/images/blockchain.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AiMlPage()),
                        );
                      },
                      child: VaibhavContainerSmall(
                        height: height / 4.8,
                        width: width * 0.4,
                        title: "AI/ML",
                        image: AssetImage("assets/images/aiml.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => UiUxPage()),
                        );
                      },
                      child: VaibhavContainerSmall(
                        height: height / 4.8,
                        width: width * 0.4,
                        title: "UI/UX",
                        image: AssetImage("assets/images/uiux.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CoreDevPage()),
                        );
                      },
                      child: VaibhavContainerSmall(
                        height: height / 4.8,
                        width: width * 0.4,
                        title: "CoreDev",
                        image: AssetImage("assets/images/core.png"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => GameDevPage()),
                        );
                      },
                      child: VaibhavContainerSmall(
                        height: height / 4.8,
                        width: width * 0.4,
                        title: "Game Dev",
                        image: AssetImage("assets/images/game.png"),
                      ),
                    ),
                    // Add more GestureDetector wrapped VaibhavContainerSmall widgets here as needed
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Text(
                  "Other Activities",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    VaibhavContainerSmall(
                      height: height / 4.8,
                      width: width * 0.4,
                      title: "Networking Event",
                      image: AssetImage("assets/images/network.png"),
                    ),
                    VaibhavContainerSmall(
                      height: height / 4.8,
                      width: width * 0.4,
                      title: "Guest Lecture",
                      image: AssetImage("assets/images/guest.png"),
                    ),
                    VaibhavContainerSmall(
                      height: height / 4.8,
                      width: width * 0.4,
                      title: "Workshop on Blockchain",
                      image: AssetImage("assets/images/blockchain.png"),
                    ),
                    // Add more VaibhavContainers here as needed
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


