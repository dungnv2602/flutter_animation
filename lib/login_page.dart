import 'package:flutter/material.dart';
import 'raised_gradient_button.dart';
class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text('Login',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  shadows: [BoxShadow(color: Colors.black12, blurRadius: 1.5, offset: Offset(0, 1.5))])),
          const SizedBox(height: 24.0),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Username', border: OutlineInputBorder()),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Password', border: OutlineInputBorder()),
            ),
          ),
          RaisedGradientButton(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: const Text(
                'LOGIN',
                style: TextStyle(color: Colors.white),
              ),
              gradient: LinearGradient(colors: <Color>[Colors.amber[300], Colors.amber[600], Colors.amber[900]]),
              onPressed: () {
                print('LOGIN button clicked');
              }),
          RaisedGradientButton(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: const Text(
                'SIGNUP',
                style: TextStyle(color: Colors.white),
              ),
              gradient: const LinearGradient(colors: <Color>[Colors.white, Colors.white12]),
              onPressed: () {
                print('SIGNUP button clicked');
              }),
        ],
      ),
    );
  }
}
