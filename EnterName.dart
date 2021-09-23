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
import 'package:money4/PassCode.dart';
import 'package:money4/api_exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AlertDialog.dart';

class EnterName extends StatefulWidget {
  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}
class _GridPerformancePage extends State<EnterName> {
  TextEditingController nameController = TextEditingController();

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
                          Text("Atrás",style: TextStyle(color: Colors.black),)
                        ]
                    ),),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),

                    child: Text("¿Cuál es tu nombre?",style: TextStyle(fontSize: 32.0 ,fontWeight:FontWeight.bold,color: Colors.black,fontFamily: 'TestDomaineDisplay'),
                    ),),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 0, top:0, right: 0, bottom:0),

                    child: Text("Unos datos de interés aquí",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'TestDomaineDisplay'),
                    ),),
                  //Enviar el código de verificación a este número
                  Container(
                      margin: EdgeInsets.only(left:0,top:30,right:0,bottom:0),
                      child: Column(children: <Widget>[
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
                                child: Text("Siguiente",
                                    style: TextStyle(fontSize: 15,)),
                              ),
                              ),

                            ],
                          ),
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                            child: Text("Saltar",style: TextStyle(color: Color.fromRGBO(6, 16, 71, 1)),),
                          ),
                          onTap: (){
                            // Navigator.push(
                            // context,
                            // MaterialPageRoute(builder: (context) => PassCode()),
                          // );
                      },
                        ),


                      ],
                      )),])));
  }


}