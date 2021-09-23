import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:money4/EnterPhone.dart';
import 'package:money4/FingetTouch_id.dart';
import 'package:money4/api_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AlertDialog.dart';

class Welcome extends StatefulWidget {
  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}
class _GridPerformancePage extends State<Welcome> {
  TextEditingController PhoneController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  Timer _timer;
  int _start = 300;
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // appBar: AppBar(
        //   title: Text('Loan App'),
        // ),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              // mainAxisAlignment : MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 24, top:30, right: 0, bottom:0),
                  child: Text("Money4",style: TextStyle(fontSize: 25.05 ,fontWeight:FontWeight.w700,color: Color.fromRGBO(1, 94, 179, 1),fontFamily: 'TestDomaineDisplay'),
                ),),

                Expanded(
                  child: Column( // this i wanted to aling center.....
                    mainAxisAlignment : MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [

                        Container(
                          margin: EdgeInsets.only(left: 24, top:0, right: 24, bottom:0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            // alignment: Alignment.centerLeft,
                            child: Text("Dinero para ti -",style: TextStyle(fontSize: 40.0 ,fontWeight:FontWeight.w700,color: Color.fromRGBO(1, 94, 179, 1),fontFamily: 'SFPRODISPLAY'),
                            ),),),
                        Container(
                          margin: EdgeInsets.only(left: 24, top:0, right: 24, bottom:0),
                          alignment: Alignment.centerLeft,
                          child: Text("cuando más lo",style: TextStyle(fontSize: 40.0 ,fontWeight:FontWeight.w700,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'SFPRODISPLAY'),
                          ),),
                        Container(
                          margin: EdgeInsets.only(left: 24, top:0, right: 24, bottom:0),
                          alignment: Alignment.centerLeft,
                          child: Text("necesites",style: TextStyle(fontSize: 40.0 ,fontWeight:FontWeight.w700,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'SFPRODISPLAY'),
                          ),),
                      Container(
                        margin: EdgeInsets.only(left:24,top:30,right:24,bottom:0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(child: new RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  side: BorderSide(color: Color.fromRGBO(6, 16, 71, 1))),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => EnterPhone()));
                              },
                              padding: EdgeInsets.all(15.0),
                              color: Color.fromRGBO(6, 16, 71, 1),
                              textColor: Colors.white,
                              child: Text("Empezar",
                                  style: TextStyle(fontSize: 16,)),
                                ),
                            ),

                            SizedBox(
                              width: 12.0,
                            ),

                            Expanded(
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    side: BorderSide(color: Color.fromRGBO(1, 94, 179, 1))),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => FingureTouch_id()));
                                },
                                padding: EdgeInsets.all(15.0),
                                color: Color.fromRGBO(1, 94, 179, 1),
                                textColor: Colors.white,
                                child: Text("Acceder",
                                    style: TextStyle(fontSize: 16)),
                              ),
                            )
                          ],
                        ),
                      ),
                      ]),
                ),



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
            myPrefs.setInt('OTP',null);
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