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
import 'package:money4/EnterName.dart';
import 'package:money4/api_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'AlertDialog.dart';

class EnterOtp_ extends StatefulWidget {
  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}
class _GridPerformancePage extends State<EnterOtp_> {
  int _otpCodeLength = 4;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
  }

  /// get signature code
  _getSignatureCode() async {
    String signature = await SmsRetrieved.getAppSignature();
    print("signature $signature");
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        // _enableButton = false;
        // _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        // _enableButton = true;
        // _isLoadingButton = false;
        _verifyOtpCode();
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(new FocusNode());
    Timer(Duration(milliseconds: 0), () {
      setState(() {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EnterName()));
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
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),
                          child: Row(
                              children: <Widget>[
                                Icon(Icons.arrow_back_ios),
                                Text("Atrás",style: TextStyle(color: Colors.black),)
                              ]
                          ),),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),

                          child: Text("Código-4 dígitos",style: TextStyle(fontSize: 32.0 ,fontWeight:FontWeight.bold,color: Colors.black,fontFamily: 'SFPRODISPLAY'),
                          ),),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 0, top:0, right: 0, bottom:0),

                          child: Text("Introduce el código que te hemos enviado a +79124214287",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'SFPRODISPLAY'),
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