import 'package:flutter/material.dart';
import 'Tache1_main.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

void main() => runApp(TextRecognitionApp());

class TextRecognitionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Text Recognition App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
      routes: {
        HomePage.routeName: (context) => HomePage(),
        ProfilePage.routeName: (context) => ProfilePage(),
        TextRecognition.routeName: (context) => TextRecognition(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => LoginPage();
}

class LoginPage extends State<MyHomePage> {
  static const String routeName = '/login';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  void _login() {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email == "john.doe@example.com" && password == "jonhpass@") {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>  HomePage(),
          ));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Connection error ⛔'),
          content: Text(
              "Veuillez enter 'john.doe@example.com' as email and 'jonhpass@' as password to be connectedpann ! 😊"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Se connecter'),
            ),
            SizedBox(height: 16.0),
            TextButton(
              child: Text('Create Account'),
              onPressed: () {
                // Navigate to create account page
              },
            ),
          ],
        ),
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
    profilePicture: 'assets/images/profil.PNG',
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
            SizedBox(height: 20.0),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profil.PNG'),
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

class TextRecognition extends StatefulWidget {
  static const String routeName = '/home_app';


  @override
  _TextRecognitionAppState createState() => _TextRecognitionAppState();
}


class _TextRecognitionAppState extends State<TextRecognition> {

  PickedFile? _imageFile;
  List<TextBlock> _textBlocks = [];

  Future<void> _getImageAndRecognizeText(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
      _textBlocks = [];
    });

    if (_imageFile != null) {
      final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(File(_imageFile!.path));
      final TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
      final VisionText visionText = await textRecognizer.processImage(visionImage);

      setState(() {
        _textBlocks = visionText.blocks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Recognition App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _imageFile == null
                ? Text('No image selected.')
                : Image.file(File(_imageFile!.path)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Take a picture'),
              onPressed: () => _getImageAndRecognizeText(ImageSource.camera),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Select from gallery'),
              onPressed: () => _getImageAndRecognizeText(ImageSource.gallery),
            ),
            SizedBox(height: 20),
            _textBlocks.isEmpty
                ? Text('No text recognized.')
                : Column(
                    children: _textBlocks.map((block) {
                      return Text(block.text ?? '');
                    }).toList(),
                  ),
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
        title: Text('Welcome Text Recognition App'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                Navigator.pushNamed(context, TextRecognition.routeName);
              },
            ),
            ListTile(
              title: Text('Login'),
              onTap: () {
                Navigator.pop(context); // Fermer le drawer
                Navigator.pushNamed(context, LoginPage.routeName);
              },
            ) ,
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
        child: Text('Welcom here !'),
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
