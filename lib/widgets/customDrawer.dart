import 'package:flutter/material.dart';
import 'package:mon_premier_projet/screens/about_page.dart';
import 'package:mon_premier_projet/screens/home_page.dart';

class MyDrawer extends StatelessWidget {
  final String currentPage;

  const MyDrawer({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                  'assets/images/iPhone-17-Air-apple.webp',
                ),
              ),
            ],
          ),
          ListTile(
            title: Text(
              "Home",
              style: currentPage == "Home"
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    )
                  : TextStyle(fontWeight: FontWeight.normal),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              if (this.currentPage == "Home") return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => MyHomePage(title: "Home"),
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              "About",
              style: currentPage == "About"
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    )
                  : TextStyle(fontWeight: FontWeight.normal),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              if (this.currentPage == "About") return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyAboutPage(title: 'About'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
