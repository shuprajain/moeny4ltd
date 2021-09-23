

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locker/flutter_locker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:money4/CameraImage.dart';
import 'package:money4/LoanHome.dart';
import 'package:money4/LockScreen.dart';
import 'package:money4/SharedPreferencesHelper.dart';
import 'package:money4/WelCome.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:url_launcher/url_launcher.dart';
import 'AlertDialog.dart';
import 'api_exceptions.dart';
const bool debugEnableDeviceSimulator = true;

Future main() async {
  // SharedPreferences.setMockInitialValues({});

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  int a;
  String b ;
  SharedPreferences prefs;
  Widget w ;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter 1234',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: CameraImage(title: "",),
      home: MyHomePage(title: "",),
      // home: HomeScreen(),
      // home: LockScreen(),
      // home: EnterOtp(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title, bool enable}) : super(key: key);
  final String title;
  String s = "lockScreen";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController docNumberController = TextEditingController();
  String dropdownValue = 'DNI';

  @override
  Widget build(BuildContext context) {
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
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: docNumberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Doc Number',
                    ),
                  ),
                ),
                InkWell(
               child: Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Text("Choose Doc Type"),
                ),
                  onTap: (){ Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Welcome()),
                  );},
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child:  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;

                        print(dropdownValue);
                      });
                    },
                    items: <String>['DNI', 'NIE']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ),


                Container(
                    child: Row(
                      children: <Widget>[
                        Text('Not verified yet?'),
                        FlatButton(
                          textColor: Colors.blue,
                          child: Text(
                            'Verify',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            //signup screen
                            _callApi(context);
                          },
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ))
              ],
            )));
  }

  _callApi(BuildContext context) {
    dynamic body = json.encode({
      "verification": {
        "callback": "https://veriff.com",
        "person": {
          "firstName": "John",
          "lastName": "Smith",
          "idNumber": "123456789"
        },
        "document": {
          "number": "B01234567",
          "type": "PASSPORT",
          "country": "EE"
        },
        "vendorData": "11111111",
        "timestamp": "2016-05-19T08:30:25.597Z"
      }
    });
    post("https://stationapi.veriff.com/v1/sessions",body).then((r) async {
      print(r.statusCode); //
      print((r.body));//

      if (r.statusCode == 201) {
        print(json.decode(r.body)["verification"]["url"]);
        if( json.decode(r.body)["status"]=="success"){
          // StorageUtil.setDouble("value",0.0);
          var baseDialog = BaseAlertDialog(
            title: "Confirm Verification",
            content: "Please verify yourself",
            yesOnPressed: () {
             child:  FutureBuilder<dynamic>(
                      future: _launchURL(json.decode(r.body)["verification"]["url"]),
                      builder: (context, snapshot) {
                        return CircularProgressIndicator();
                      }


            );},
            noOnPressed: () {},
            yes: "verify",);
          showDialog(context: context, builder: (BuildContext context) => baseDialog);
        }else{
          double value = json.decode(r.body)["Result"]["Value"];

          // StorageUtil.setDouble("value",value);
        }

      }
    });
  }

  _launchURL(String url) async {
    // String url = s;
    if (await canLaunch(url)) {
      await launch("https://pub.dev/packages/url_launcher/example");
    } else {
      throw 'Could not launch $url';
    }
  }
  Future<http.Response> post(String url,dynamic body) async {

    var headers = {
      'Content-Type': 'application/json',
      'X-AUTH-CLIENT' : '66d3008a-cbf0-4130-9415-74b87660f633',
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

}

//ye hai jisme code insert karenge
class EnterOtp extends StatefulWidget {
  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}
class _GridPerformancePage extends State<EnterOtp> {
  int a ;
  int b ;
  SharedPreferences prefs;
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

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
            MaterialPageRoute(builder: (context) => Welcome()));
        // _isLoadingButton = false;
        // _enableButton = false;
      });
    }).catchError((err) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('Error happened: ' + err.toString())));
    });
  }
  // @override
  // void initState() {
  //   super.initState();
  //   // _getSignatureCode();
  // }

  /// get signature code
  // _getSignatureCode() async {
  //   String signature = await SmsRetrieved.getAppSignature();
  //   print("signature $signature");
  // }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  // is it working
  // 1 digit enter ke baad hi chal ja raha woh
  _onOtpCallBack(String otpCode, bool isAutofill) async {

    if(prefs==null) {
      prefs = await SharedPreferences.getInstance();
    }

    setState(() {
      if(!prefs.containsKey("lockPass")){
        this._otpCode = otpCode;
        if (otpCode.length == _otpCodeLength && isAutofill) {
          print("----------"+otpCode);
          _verifyOtpCode();
        } else if (otpCode.length == _otpCodeLength && !isAutofill) {
          prefs.setString("lockPass", otpCode);
          print("----------"+otpCode);
          _verifyOtpCode();
        } else {
          _enableButton = false;
        }
      } else {
        print(otpCode);

        // prefs.setString("lockPass", otpCode).then((v){
        //   this._otpCode = otpCode;
          if (otpCode.length == _otpCodeLength && isAutofill) {
            if(otpCode == prefs.getString("lockPass")) {
              _verifyOtpCode1();
            }
          } else if (otpCode.length == _otpCodeLength && !isAutofill) {
            if(otpCode == prefs.getString("lockPass")) {
              _verifyOtpCode1();
            }
          } else {
            _enableButton = false;
          }
        // }).catchError((e){
        //
        // });
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 0), () {
      setState(() {
        print("888888"+prefs.getString("lockPass"));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EnterOtp1()));
        // _isLoadingButton = false;
        // _enableButton = false;
      });
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }
  _verifyOtpCode1() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 0), () {
      setState(() {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => touchid()));
        // _isLoadingButton = false;
        // _enableButton = false;
      });

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }
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
                margin: EdgeInsets.only(left: 0, top:120, right: 0, bottom:0),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),

                      child: Text("Introducir tu Código de Acceso",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.w600,color: Colors.black,fontFamily: 'SFPRODISPLAY'),
                      ),),

                    Container(
                      margin: EdgeInsets.only(left:0,top:30,right:0,bottom:0),
                      child: TextFieldPin(
                        filled: true,
                        filledColor: Colors.black12,
                        codeLength: _otpCodeLength,
                        boxSize: 46,
                        filledAfterTextChange: false,
                        textStyle: TextStyle(fontSize: 16),
                        borderStyeAfterTextChange: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        borderStyle: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12)),
                        onOtpCallback: (code, isAutofill) =>
                            _onOtpCallBack(code, isAutofill),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            child: Text("Cerrar Sesión",style: TextStyle(fontSize: 16.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'TestDomaineDisplay'),

                            ),),
                          IconButton(
                              alignment: Alignment.center ,
                              padding: EdgeInsets.only(left: 24, top:20, right: 0, bottom:0),
                              iconSize: 40,
                              // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                              icon: Image.asset("assets/images/finger_id.png",width:40,height:40),
                              onPressed: () {
                                print("*******");
                                //Navigator.of(context).pop();
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                        elevation: 16,
                                        child: Container(
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                          IconButton(
                                          alignment: Alignment.center ,
                                            padding: EdgeInsets.only(left: 0, top:20, right: 0, bottom:0),
                                            iconSize: 40,
                                            // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                            icon: Image.asset("assets/images/finger_id.png",width:40,height:40),),
                                              Container(
                                                margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                                // alignment: Alignment.center,
                                                child: Text("Touch ID para ”Money-4”",textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontWeight: FontWeight.w600,fontSize: 20.0,fontFamily: 'SFPRODISPLAY'),),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:15),
                                                // alignment: Alignment.center,
                                                child: Text("Identifícate con Touch ID",textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontWeight: FontWeight.w600,fontSize: 13.0,fontFamily: 'SFPRODISPLAY'),),
                                              ),
                                              Divider(
                                                thickness: 1,
                                                color: Color.fromRGBO(178, 178, 178, 1),
                                              ),
                                              IntrinsicHeight(
                                                child:   Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget>[
                                                    InkWell(
                                                      child:  Container(

                                                        margin: EdgeInsets.only(left: 24, top:7.5, right: 24, bottom:15),
                                                        alignment: Alignment.center,
                                                        child: Text("Cancelar",style: TextStyle(color: Color.fromRGBO(0, 122, 255, 1),fontWeight: FontWeight.w600,fontSize: 17.0,fontFamily: 'SFPRODISPLAY'),),
                                                      ),
                                                      onTap: (){
                                                        _saveSecret(context);
                                                      },
                                                    ),
                                                  ],
                                                ),),
                                            ],
                                          ),
                                        ),
                                      );});
                              }),
                        ],
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }
}

class EnterOtp1 extends StatefulWidget {
  @override
  _GridPerformancePage1 createState() => new _GridPerformancePage1();
}
class _GridPerformancePage1 extends State<EnterOtp1> {
  int a;
  int b ;
  SharedPreferences prefs;
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // _getSignatureCode();
  }

  /// get signature code
  // _getSignatureCode() async {
  //   String signature = await SmsRetrieved.getAppSignature();
  //   print("signature $signature");
  // }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) async {

    if(prefs==null) {
      prefs = await SharedPreferences.getInstance();
    }

    setState(() {
      if(prefs.containsKey("lockPass")){
        print("----------"+prefs.getString("lockPass"));
        this._otpCode = otpCode;
        if (otpCode.length == _otpCodeLength && isAutofill) {
          if(otpCode == prefs.getString("lockPass")) {
            prefs.setString("lockPass", otpCode);
            _verifyOtpCode();
          }
        } else if (otpCode.length == _otpCodeLength && !isAutofill) {
          if(otpCode == prefs.getString("lockPass")) {
            prefs.setString("lockPass", otpCode);
            _verifyOtpCode();
          }
        } else {
          _enableButton = false;
        }
      } else {
        // prefs.setString("lockPass", otpCode).then((v){
        //   this._otpCode = otpCode;
        //   if (otpCode.length == _otpCodeLength && isAutofill) {
        //     _verifyOtpCode1();
        //   } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        //     _verifyOtpCode1();
        //   } else {
        //     _enableButton = false;
        //   }
        // }).catchError((e){

        // });
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 0), () {
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Welcome()));
        // _isLoadingButton = false;
        // _enableButton = false;
      });

      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));
    });
  }

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
            mainAxisAlignment : MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),
                    //   child: Row(
                    //       children: <Widget>[
                    //         Icon(Icons.arrow_back_ios),
                    //         Text("Atrás",style: TextStyle(color: Colors.black),)
                    //       ]
                    //   ),),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),

                      child: Text("Introducir tu Código de Acceso",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.bold,color: Colors.black,fontFamily: 'SFPRODISPLAY'),
                      ),),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   margin: EdgeInsets.only(left: 0, top:0, right: 0, bottom:0),
                    //
                    //   child: Text("Introduce el código que te hemos enviado a +79124214287",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'SFPRODISPLAY'),
                    //   ),),
                    Container(
                      margin: EdgeInsets.only(left:0,top:30,right:0,bottom:0),
                      child: TextFieldPin(
                        filled: true,
                        filledColor: Colors.black12,
                        codeLength: _otpCodeLength,
                        boxSize: 46,
                        filledAfterTextChange: false,
                        textStyle: TextStyle(fontSize: 16),
                        borderStyeAfterTextChange: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        borderStyle: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12)),
                        onOtpCallback: (code, isAutofill) =>
                            _onOtpCallBack(code, isAutofill),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    // Container(
                    //   width: double.maxFinite,
                    //   child: MaterialButton(
                    //     onPressed: _enableButton ? _onSubmitOtp : null,
                    //     child: _setUpButtonChild(),
                    //     color: Colors.blue,
                    //     disabledColor: Colors.blue[100],
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget _setUpButtonChild() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Verify",
        style: TextStyle(color: Colors.white),
      );
    }
  }
}
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:video_player/video_player.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Picker Demo',
//       home: MyHomePage(title: 'Image Picker Example'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, this.title}) : super(key: key);
//
//   final String? title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<XFile>? _imageFileList;
//
//   set _imageFile(XFile? value) {
//     _imageFileList = value == null ? null : [value];
//   }
//
//   dynamic _pickImageError;
//   bool isVideo = false;
//
//   VideoPlayerController? _controller;
//   VideoPlayerController? _toBeDisposed;
//   String? _retrieveDataError;
//
//   final ImagePicker _picker = ImagePicker();
//   final TextEditingController maxWidthController = TextEditingController();
//   final TextEditingController maxHeightController = TextEditingController();
//   final TextEditingController qualityController = TextEditingController();
//
//   Future<void> _playVideo(XFile? file) async {
//     if (file != null && mounted) {
//       await _disposeVideoController();
//       late VideoPlayerController controller;
//       if (kIsWeb) {
//         controller = VideoPlayerController.network(file.path);
//       } else {
//         controller = VideoPlayerController.file(File(file.path));
//       }
//       _controller = controller;
//       // In web, most browsers won't honor a programmatic call to .play
//       // if the video has a sound track (and is not muted).
//       // Mute the video so it auto-plays in web!
//       // This is not needed if the call to .play is the result of user
//       // interaction (clicking on a "play" button, for example).
//       final double volume = kIsWeb ? 0.0 : 1.0;
//       await controller.setVolume(volume);
//       await controller.initialize();
//       await controller.setLooping(true);
//       await controller.play();
//       setState(() {});
//     }
//   }
//
//   void _onImageButtonPressed(ImageSource source,
//       {BuildContext? context, bool isMultiImage = false}) async {
//     if (_controller != null) {
//       await _controller!.setVolume(0.0);
//     }
//     if (isVideo) {
//       final XFile? file = await _picker.pickVideo(
//           source: source, maxDuration: const Duration(seconds: 10));
//       await _playVideo(file);
//     } else if (isMultiImage) {
//       await _displayPickImageDialog(context!,
//               (double? maxWidth, double? maxHeight, int? quality) async {
//             try {
//               final pickedFileList = await _picker.pickMultiImage(
//                 maxWidth: maxWidth,
//                 maxHeight: maxHeight,
//                 imageQuality: quality,
//               );
//               setState(() {
//                 _imageFileList = pickedFileList;
//               });
//             } catch (e) {
//               setState(() {
//                 _pickImageError = e;
//               });
//             }
//           });
//     } else {
//       await _displayPickImageDialog(context!,
//               (double? maxWidth, double? maxHeight, int? quality) async {
//             try {
//               final pickedFile = await _picker.pickImage(
//                 source: source,
//                 maxWidth: maxWidth,
//                 maxHeight: maxHeight,
//                 imageQuality: quality,
//               );
//               setState(() {
//                 _imageFile = pickedFile;
//               });
//             } catch (e) {
//               setState(() {
//                 _pickImageError = e;
//               });
//             }
//           });
//     }
//   }
//
//   @override
//   void deactivate() {
//     if (_controller != null) {
//       _controller!.setVolume(0.0);
//       _controller!.pause();
//     }
//     super.deactivate();
//   }
//
//   @override
//   void dispose() {
//     _disposeVideoController();
//     maxWidthController.dispose();
//     maxHeightController.dispose();
//     qualityController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _disposeVideoController() async {
//     if (_toBeDisposed != null) {
//       await _toBeDisposed!.dispose();
//     }
//     _toBeDisposed = _controller;
//     _controller = null;
//   }
//
//   Widget _previewVideo() {
//     final Text? retrieveError = _getRetrieveErrorWidget();
//     if (retrieveError != null) {
//       return retrieveError;
//     }
//     if (_controller == null) {
//       return const Text(
//         'You have not yet picked a video',
//         textAlign: TextAlign.center,
//       );
//     }
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: AspectRatioVideo(_controller),
//     );
//   }
//
//   Widget _previewImages() {
//     final Text? retrieveError = _getRetrieveErrorWidget();
//     if (retrieveError != null) {
//       return retrieveError;
//     }
//     if (_imageFileList != null) {
//       return Semantics(
//           child: ListView.builder(
//             key: UniqueKey(),
//             itemBuilder: (context, index) {
//               // Why network for web?
//               // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
//               return Semantics(
//                 label: 'image_picker_example_picked_image',
//                 child: kIsWeb
//                     ? Image.network(_imageFileList![index].path)
//                     : Image.file(File(_imageFileList![index].path)),
//               );
//             },
//             itemCount: _imageFileList!.length,
//           ),
//           label: 'image_picker_example_picked_images');
//     } else if (_pickImageError != null) {
//       return Text(
//         'Pick image error: $_pickImageError',
//         textAlign: TextAlign.center,
//       );
//     } else {
//       return const Text(
//         'You have not yet picked an image.',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
//
//   Widget _handlePreview() {
//     if (isVideo) {
//       return _previewVideo();
//     } else {
//       return _previewImages();
//     }
//   }
//
//   Future<void> retrieveLostData() async {
//     final LostDataResponse response = await _picker.retrieveLostData();
//     if (response.isEmpty) {
//       return;
//     }
//     if (response.file != null) {
//       if (response.type == RetrieveType.video) {
//         isVideo = true;
//         await _playVideo(response.file);
//       } else {
//         isVideo = false;
//         setState(() {
//           _imageFile = response.file;
//           _imageFileList = response.files;
//         });
//       }
//     } else {
//       _retrieveDataError = response.exception!.code;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title!),
//       ),
//       body: Center(
//         child: !kIsWeb && defaultTargetPlatform == TargetPlatform.android
//             ? FutureBuilder<void>(
//           future: retrieveLostData(),
//           builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.none:
//               case ConnectionState.waiting:
//                 return const Text(
//                   'You have not yet picked an image.',
//                   textAlign: TextAlign.center,
//                 );
//               case ConnectionState.done:
//                 return _handlePreview();
//               default:
//                 if (snapshot.hasError) {
//                   return Text(
//                     'Pick image/video error: ${snapshot.error}}',
//                     textAlign: TextAlign.center,
//                   );
//                 } else {
//                   return const Text(
//                     'You have not yet picked an image.',
//                     textAlign: TextAlign.center,
//                   );
//                 }
//             }
//           },
//         )
//             : _handlePreview(),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           Semantics(
//             label: 'image_picker_example_from_gallery',
//             child: FloatingActionButton(
//               onPressed: () {
//                 isVideo = false;
//                 _onImageButtonPressed(ImageSource.gallery, context: context);
//               },
//               heroTag: 'image0',
//               tooltip: 'Pick Image from gallery',
//               child: const Icon(Icons.photo),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 isVideo = false;
//                 _onImageButtonPressed(
//                   ImageSource.gallery,
//                   context: context,
//                   isMultiImage: true,
//                 );
//               },
//               heroTag: 'image1',
//               tooltip: 'Pick Multiple Image from gallery',
//               child: const Icon(Icons.photo_library),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: FloatingActionButton(
//               onPressed: () {
//                 isVideo = false;
//                 _onImageButtonPressed(ImageSource.camera, context: context);
//               },
//               heroTag: 'image2',
//               tooltip: 'Take a Photo',
//               child: const Icon(Icons.camera_alt),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: FloatingActionButton(
//               backgroundColor: Colors.red,
//               onPressed: () {
//                 isVideo = true;
//                 _onImageButtonPressed(ImageSource.gallery);
//               },
//               heroTag: 'video0',
//               tooltip: 'Pick Video from gallery',
//               child: const Icon(Icons.video_library),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 16.0),
//             child: FloatingActionButton(
//               backgroundColor: Colors.red,
//               onPressed: () {
//                 isVideo = true;
//                 _onImageButtonPressed(ImageSource.camera);
//               },
//               heroTag: 'video1',
//               tooltip: 'Take a Video',
//               child: const Icon(Icons.videocam),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Text? _getRetrieveErrorWidget() {
//     if (_retrieveDataError != null) {
//       final Text result = Text(_retrieveDataError!);
//       _retrieveDataError = null;
//       return result;
//     }
//     return null;
//   }
//
//   Future<void> _displayPickImageDialog(
//       BuildContext context, OnPickImageCallback onPick) async {
//     return showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: Text('Add optional parameters'),
//             content: Column(
//               children: <Widget>[
//                 TextField(
//                   controller: maxWidthController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration:
//                   InputDecoration(hintText: "Enter maxWidth if desired"),
//                 ),
//                 TextField(
//                   controller: maxHeightController,
//                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                   decoration:
//                   InputDecoration(hintText: "Enter maxHeight if desired"),
//                 ),
//                 TextField(
//                   controller: qualityController,
//                   keyboardType: TextInputType.number,
//                   decoration:
//                   InputDecoration(hintText: "Enter quality if desired"),
//                 ),
//               ],
//             ),
//             actions: <Widget>[
//               TextButton(
//                 child: const Text('CANCEL'),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),
//               TextButton(
//                   child: const Text('PICK'),
//                   onPressed: () {
//                     double? width = maxWidthController.text.isNotEmpty
//                         ? double.parse(maxWidthController.text)
//                         : null;
//                     double? height = maxHeightController.text.isNotEmpty
//                         ? double.parse(maxHeightController.text)
//                         : null;
//                     int? quality = qualityController.text.isNotEmpty
//                         ? int.parse(qualityController.text)
//                         : null;
//                     onPick(width, height, quality);
//                     Navigator.of(context).pop();
//                   }),
//             ],
//           );
//         });
//   }
// }
//
// typedef void OnPickImageCallback(
//     double? maxWidth, double? maxHeight, int? quality);
//
// class AspectRatioVideo extends StatefulWidget {
//   AspectRatioVideo(this.controller);
//
//   final VideoPlayerController? controller;
//
//   @override
//   AspectRatioVideoState createState() => AspectRatioVideoState();
// }
//
// class AspectRatioVideoState extends State<AspectRatioVideo> {
//   VideoPlayerController? get controller => widget.controller;
//   bool initialized = false;
//
//   void _onVideoControllerUpdate() {
//     if (!mounted) {
//       return;
//     }
//     if (initialized != controller!.value.isInitialized) {
//       initialized = controller!.value.isInitialized;
//       setState(() {});
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     controller!.addListener(_onVideoControllerUpdate);
//   }
//
//   @override
//   void dispose() {
//     controller!.removeListener(_onVideoControllerUpdate);
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (initialized) {
//       return Center(
//         child: AspectRatio(
//           aspectRatio: controller!.value.aspectRatio,
//           child: VideoPlayer(controller!),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }