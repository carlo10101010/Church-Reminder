import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Profile(),
  ));
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Church Reminder',
          style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold,),
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Center(
              child: Text(
                'User Profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30, // Larger font size
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Centered Icon
            const Center(
              child: Icon(
                Icons.person,
                size: 100, // Icon size
              ),
            ),

            const SizedBox(height: 16),

            // Replacing TextSpan with Text widgets for each section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Name\n',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Carlo P. Mendoza',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Email\n',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'mendozacarlo185@gmail.com',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Company\n',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Batangas State University',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 16),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Contact No.\n',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '09485315720',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Spacer(),

            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 13),
                  backgroundColor: Colors.black87
                ),
                child: const Text('Logout', style: TextStyle(
                    color:Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
