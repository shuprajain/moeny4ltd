import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:money4/api_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AlertDialog.dart';

class ResetPassPage extends StatefulWidget {

  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}
class _GridPerformancePage extends State<ResetPassPage> {
  TextEditingController PhoneController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
   Timer _timer;
  int _start = 300;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Loan App'),
        ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[

                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: PhoneController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                    ),
                    onChanged: (PhoneController){if(PhoneController.length==10){
                      _callApi(context);
                      startTimer();

                    }},
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    controller: OTPController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'OTP',
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),

                    child: FlatButton(
                      textColor: Colors.blue,
                      child: Text(
                        'Verify' ,
                        style: TextStyle(fontSize: 20),
                      ),
                      onPressed: () async {
                        //signup screen
                       SharedPreferences myPrefs = await SharedPreferences.getInstance();
                        if(OTPController.text == myPrefs.getInt('OTP').toString()){
                          Fluttertoast.showToast(
                              msg: "Matched",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1
                          );
                          dispose();
                        }else{
                          Fluttertoast.showToast(
                              msg: "Not Matched",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1
                          );
                        }
                      },
                    )
                ),
                Visibility(
                  visible:_visible,
                  child: new Container(
                    child: new  Container(
                      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 10.0),
                      child: new Material(
                        elevation: 10.0,
                        borderRadius: BorderRadius.circular(25.0),
                          child: TextField(
                            decoration: new InputDecoration(
                              hintText: 'Send OTP', border: InputBorder.none,),
                            onTap: (){
                              _callApi(context);
                            },
                          ),

                          ),
                        ),
                      ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text("Expires $_start sec"),
                ),
                // Container(
                //     child: Row(
                //       children: <Widget>[
                //         Text('Not verified yet?'),
                //         FlatButton(
                //           textColor: Colors.blue,
                //           child: Text(
                //             'Verify',
                //             style: TextStyle(fontSize: 20),
                //           ),
                //           onPressed: () {
                //             //signup screen
                //             _callApi(context);
                //           },
                //         )
                //       ],
                //       mainAxisAlignment: MainAxisAlignment.center,
                //     ))
              ],
            )));
  }

  _callApi(BuildContext context) async {
    int a = randomGen(1000, 9999);
    SharedPreferences myPrefs = await SharedPreferences.getInstance();
    myPrefs.setInt('OTP',a);
    dynamic body = json.encode({"messages":[{"source":"App","body":"surbhi jain Here is Verification Code "+a.toString(),"to":"+917987593870"}]});
    post("https://rest.clicksend.com/v3/sms/send",body).then((r) async {
      print(r.statusCode); //
      print((r.body));//

      // if (r.statusCode == 200) {
      //   print(json.decode(r.body)["verification"]["url"]);
      //   if( json.decode(r.body)["status"]=="success"){
      //     // StorageUtil.setDouble("value",0.0);
      //     var baseDialog = BaseAlertDialog(
      //       title: "Confirm Verification",
      //       content: "Please verify yourself",
      //       yesOnPressed: () {Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) =>  FutureBuilder<String>(
      //               // future: _launchURL(json.decode(r.body)["verification"]["url"]),
      //               builder: (context, snapshot) {
      //                 return CircularProgressIndicator();
      //               }
      //           ), ),
      //       );},
      //       noOnPressed: () {},
      //       yes: "verify",);
      //     showDialog(context: context, builder: (BuildContext context) => baseDialog);
      //   }else{
      //     double value = json.decode(r.body)["Result"]["Value"];
      //
      //     // StorageUtil.setDouble("value",value);
      //   }
      //
      // }
    });
  }

  Future<http.Response> post(String url,dynamic body) async {
   String token = "info@nebeus.com:AF9288F9-C564-92EE-643C-D4D83942E7B6";
   Codec<String, String> stringToBase64 = utf8.fuse(base64);
   String encoded = stringToBase64.encode(token);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization' : 'Basic ' + encoded,
    };
    try {
      Uri myUri = Uri.parse(url);
      final response = await http.post(myUri, headers:headers, body:body);
      return response ;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  randomGen(min, max) {
    // the nextInt method generate a non-ngegative random integer from 0 (inclusive) to max (exclusive)
    var x = Random().nextInt(max) + min;

    // If you don't want to return an integer, just remove the floor() method
    return x.floor();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() async {
            timer.cancel();
            SharedPreferences myPrefs = await SharedPreferences.getInstance();
            myPrefs.setInt('OTP',0);
            _toggle();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  void _toggle() {
    setState(() {
      _visible = !_visible;
    });
  }
}