import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signinauth/screens/signin_screen.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child:Text("Logout"),
          onPressed: (){
            FirebaseAuth.instance.signOut().then((value) => { Navigator.push(context,MaterialPageRoute(builder: (context)=>SignInScreen()))});
          
          },
        ),
      ),
    );
  }
}
