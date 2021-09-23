import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locker/flutter_locker.dart';
import 'package:money4/Userprofile.dart';

class FingureTouch_id extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<FingureTouch_id> {
  String key = 'pwdkey';
  String secret = '1111';
  Future<void> _saveSecret(BuildContext context) async {
    FlutterLocker.save(SaveSecretRequest(
        key, secret, AndroidPrompt('Authenticate', 'Cancel')))
        .then((value) {
      // Scaffold.of(context).showSnackBar(
      //     SnackBar(content: Text('Successfully Saved Secret: $secret')));
      print("************$secret");
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserProfile()));
        // _isLoadingButton = false;
        // _enableButton = false;
      });
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error happened: ' + err.toString())));
    });
  }

  Future<void> _canAuthenticate(BuildContext context) async {
    FlutterLocker.canAuthenticate().then((value) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Can authenticate: ' + value.toString())));
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error happened: ' + err.toString())));
    });
  }



  Future<void> _retrieveSecret(BuildContext context) async {
    FlutterLocker.retrieve(RetrieveSecretRequest(key,
        AndroidPrompt('Authenticate', 'Cancel'), IOsPrompt('Authenticate')))
        .then((value) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Retrieved secret: ' + value)));
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error happened: ' + err.toString())));
    });
  }

  Future<void> _deleteSecret(BuildContext context) async {
    FlutterLocker.delete(key).then((value) {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Secret deleted.')));
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error happened: ' + err.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,

      child: Column(
        children: <Widget>[

          // CupertinoButton.filled(
          //     child: Text('Can authenticate'),
          //     onPressed: () {
          //       _canAuthenticate(context);
          //     }),
          // SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(left: 24, top:40, right: 24, bottom:0),

            child: CupertinoButton.filled(
                child: Text('Login'),
                onPressed: () {
                  _saveSecret(context);
                }),
          ),

          SizedBox(height: 20),
          // CupertinoButton.filled(
          //     child: Text('Retrieve secret'),
          //     onPressed: () {
          //       _retrieveSecret(context);
          //     }),
          // SizedBox(height: 20),
          // CupertinoButton.filled(
          //     child: Text('Delete secret'),
          //     onPressed: () {
          //       _deleteSecret(context);
          //     })
        ],
      ),
    );
  }
}



