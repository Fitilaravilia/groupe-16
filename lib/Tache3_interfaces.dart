import 'package:flutter/material.dart';

void main() => runApp(TextRecognitionApp());

class TextRecognitionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Recognition App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        ProfilePage.routeName: (context) => ProfilePage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Text('Login Page'),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  static const String routeName = '/profile';

  // Modèle de données pour le profil
  final userProfile = UserProfile(
    name: 'John Doe',
    email: 'john.doe@example.com',
    profilePicture: 'assets/images/profile_picture.png',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(userProfile.profilePicture),
            ),
            SizedBox(height: 20),
            Text('Name: ${userProfile.name}'),
            SizedBox(height: 10),
            Text('Email: ${userProfile.email}'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                Navigator.pushNamed(context, HomePage.routeName);
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                Navigator.pushNamed(context, ProfilePage.routeName);
              },
            ),
             ListTile(
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                Navigator.pushNamed(context, ProfilePage.routeName);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}

class UserProfile {
  final String name;
  final String email;
  final String profilePicture;

  UserProfile({
    required this.name,
    required this.email,
    required this.profilePicture,
  });
}
