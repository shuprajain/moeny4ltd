import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:money4/EnterOtp.dart';
import 'package:money4/api_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AlertDialog.dart';

class EnterPhone extends StatefulWidget {
  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}
class _GridPerformancePage extends State<EnterPhone> {
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
                  margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),
                  child: Row(
                      children: <Widget>[
                        Icon(Icons.arrow_back_ios),
                        Text("Atrás",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'TestDomaineDisplay'),)
                      ]
                  ),),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),

                  child: Text("Regístrate",style: TextStyle(fontSize: 40.0 ,fontWeight:FontWeight.bold,color: Colors.black,fontFamily: 'TestDomaineDisplay'),
                  ),),
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(left: 0, top:5, right: 0, bottom:0),

                  child: Text("Enviar el código de verificación a este número",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'TestDomaineDisplay'),
                  ),),
                //Enviar el código de verificación a este número
                Container(
                  margin: EdgeInsets.only(left:0,top:30,right:0,bottom:0),
                  child: Column(children: <Widget>[
                  Container(
                      child:IntlPhoneField(
                        decoration: InputDecoration( //decoration for Input Field
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                        initialCountryCode: 'NP', //default contry code, NP for Nepal
                        onChanged: (phone) {
                          //when phone number country code is changed
                          print(phone.completeNumber); //get complete number
                          print(phone.countryCode); // get country code only
                          print(phone.number); // only phone number
                        },
                      )
                  ),


                    Container(
                      margin: EdgeInsets.only(left:0,top:15,right:0,bottom:0),
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(child: new RaisedButton(

                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                side: BorderSide(color: Color.fromRGBO(6, 16, 71, 1))),
                            onPressed: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) => EnterOtp_()));
                            },
                            padding: EdgeInsets.all(15.0),
                            color: Color.fromRGBO(6, 16, 71, 1),
                            textColor: Colors.white,
                            child: Text("Empezar",
                                style: TextStyle(fontSize: 15,)),
                          ),
                          ),

                        ],
                      ),
                    ),



                  ],
            )),])));
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