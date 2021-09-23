import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
import 'package:money4/CameraImage.dart';
import 'package:money4/EnterPhone.dart';


class UserProfile extends StatefulWidget {
  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}



class _GridPerformancePage extends State<UserProfile> {
  TextEditingController PhoneController = TextEditingController();
  TextEditingController OTPController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController Nombrecompleto = TextEditingController();
  Timer _timer;
  int _start = 300;
  bool _visible = false;
  bool visibilityObs = true;

  bool visibilitySeguri = false;

  bool visibilitySeguri1 = false;

  bool _hasBeenPressed = true;
  bool _hasBeenPressed2 = false;
  bool _hasBeenPressed3 = false;
  bool isSwitched = false;


  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "obs") {
        visibilityObs = visibility;
      }
      if (field == "seg") {
        visibilitySeguri = visibility;
      }
      if (field == "seg1") {
        visibilitySeguri1 = visibility;
      }
    });
  }






  // void _handleURLButtonPress(BuildContext context, var type) {
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => ImageFromGalleryEx(type)));
  // }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
    body: ListView(
      children: <Widget>[
    Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      IconButton(
          alignment: Alignment.center ,
          padding: EdgeInsets.only(left: 24, top:20, right: 0, bottom:0),

          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () { print("Pressed"); }
      ),
        new Spacer(),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 24, top:20, right: 0, bottom:0),

          child: Text("Perfil",style: TextStyle(fontSize: 16.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
          ),),
      new Spacer(),
      new Spacer(),
    ]),
        Container(
          margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white70,
                    minRadius: 40.0,
                    child: CircleAvatar(
                      radius: 40.0,
                      backgroundImage:
                      NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 10, top:0, right: 0, bottom:0),
                      child: Text("Surbhi Jain",style: TextStyle(fontSize: 24.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                      ),),
                    InkWell(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 10, top:0, right: 0, bottom:0),
                        child: Text(
                          'Editar',
                          style: TextStyle(
                            fontSize: 16,
                            color:Color.fromRGBO(1, 94, 179, 1),
                          ),

                        ),),
                      onTap: (){
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                                color: Colors.white,
                                child: Center(
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children :<Widget>[ CircleAvatar(
                                          backgroundColor: Colors.white70,
                                          minRadius: 40.0,
                                          child: CircleAvatar(
                                            radius: 40.0,
                                            backgroundImage:
                                            NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                                          ),
                                        ),
                                      ]),

                                      Container(
                                        margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                        alignment: Alignment.center,
                                        child: Text("Cambiar foto de perfil",style: TextStyle(color: Color.fromRGBO(1, 94, 179, 1),fontWeight: FontWeight.w600,fontSize: 14.0),),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                        child: TextField(
                                          obscureText: false,
                                          controller: Nombrecompleto,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Nombre completo',
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child:  FlatButton(
                                                child: Text('Aceptar', style: TextStyle(fontSize: 12.0,color: Colors.white),),
                                                color:  Color.fromRGBO(6, 16, 71, 1),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)),
                                                textColor: Color.fromRGBO(1, 94, 179, 1) ,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  showModalBottomSheet<void>(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return Container(
                                                          height: 180,
                                                          color: Colors.white,
                                                          child: Center(
                                                            child: Column(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: <Widget>[
                                                                Container(
                                                                  margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                                                  alignment: Alignment.topLeft,
                                                                  child: Text("Editar foto de perfil",style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontWeight: FontWeight.w600,fontSize: 24.0),),
                                                                ),

                                                                Container(
                                                                  margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                        child:  FlatButton(
                                                                          child: Text('Hacer foto', style: TextStyle(fontSize: 12.0,color: Colors.white),),
                                                                          color:  Color.fromRGBO(6, 16, 71, 1),
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                          textColor: Color.fromRGBO(1, 94, 179, 1) ,
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop();
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
                                                                                    Container(
                                                                                      margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
                                                                                      // alignment: Alignment.center,
                                                                                      child: Text("Money-4 desea acceder  a la cámara",textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontWeight: FontWeight.w600,fontSize: 17.0),),
                                                                                    ),
                                                                                    Container(
                                                                                      margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                                                                      // alignment: Alignment.center,
                                                                                      child: Text("Money-4 tiene acceso a tu cámara",textAlign: TextAlign.center,style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontWeight: FontWeight.w600,fontSize: 13.0),),
                                                                                    ),
                                                                                    Divider(
                                                                                      thickness: 1,
                                                                                      color: Color.fromRGBO(0, 0, 0, 0.5),
                                                                                    ),
                                                                             IntrinsicHeight(
                                                                                 child:   Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                      children: <Widget>[
                                                                                        InkWell(
                                                                                          child:  Container(

                                                                                            margin: EdgeInsets.only(left: 24, top:0, right: 24, bottom:10),
                                                                                            alignment: Alignment.center,
                                                                                            child: Text("No permitir",style: TextStyle(color: Color.fromRGBO(0, 122, 255, 1),fontWeight: FontWeight.w600,fontSize: 17.0),),
                                                                                          ),
                                                                                          onTap: (){
                                                                                            Navigator.of(context).pop();
                                                                                          },
                                                                                        ),

                                                                                        VerticalDivider(color: Color.fromRGBO(0, 0, 0, 0.5),thickness: 1,),
                                                                                        InkWell(
                                                                                          child:   Container(
                                                                                            margin: EdgeInsets.only(left: 24, top:0, right: 24, bottom:10),
                                                                                            alignment: Alignment.center,
                                                                                            child: Text("OK",style: TextStyle(color: Color.fromRGBO(0, 122, 255, 1),fontWeight: FontWeight.w600,fontSize: 17.0),),
                                                                                          ),
                                                                                          onTap: () {
                                                                                            // _handleURLButtonPress(context, ImageSourceType.gallery);
                                                                                            // Navigator.push(context,
                                                                                            //     MaterialPageRoute(builder: (context) => CameraImage(title:"")));
                                                                                            // isVideo = false;
                                                                                            // _onImageButtonPressed(ImageSource.gallery, context: context);
                                                                                          }),

                                                                                      ],
                                                                                    ),),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            );});
                                                                          },
                                                                        ),),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets.only(left: 24, top:0, right: 24, bottom:0),
                                                                  child: Row(
                                                                    children: <Widget>[
                                                                      Expanded(
                                                                          child: OutlinedButton(
                                                                            onPressed: (){},
                                                                            style: OutlinedButton.styleFrom(
                                                                              side: BorderSide(
                                                                                width: 2.0,
                                                                                color:Color.fromRGBO(6, 16, 71, 1),
                                                                                style: BorderStyle.solid,
                                                                              ),
                                                                            ),
                                                                            child: Text('Subir desde el carrete de la cámara',style: TextStyle(color:Color.fromRGBO(6, 16, 71, 1),)
                                                                            ),
                                                                          )),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ));},
                                                  );
                                                },
                                              ),),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ));},
                        );
                      },
                    ),

                  ],),
                ],
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
          child: Row(
            children: <Widget>[
             FlatButton(
                child: Text('Datos personales', style: TextStyle(fontSize: 12.0),),
                color: _hasBeenPressed ? Color.fromRGBO(1, 94, 179, 1) : Color.fromRGBO(1, 94, 179, 0.08),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                textColor: _hasBeenPressed ? Colors.white : Color.fromRGBO(1, 94, 179, 1),
                onPressed: () {
                  _hasBeenPressed = true ;
                   _hasBeenPressed2 = false ;
                   _hasBeenPressed3 = false ;

                  visibilitySeguri ? _changed(false, "seg") : _changed(false, "seg");
                  visibilitySeguri1 ? _changed(false, "seg1") : _changed(false, "seg1");
                  visibilityObs ? _changed(true, "obs") : _changed(true, "obs");

                  // visibilitySeguri ? null : _changed(false, "seg");
                },
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Text('Seguridad', style: TextStyle(fontSize: 12.0),),
                color: _hasBeenPressed2 ? Color.fromRGBO(1, 94, 179, 1) : Color.fromRGBO(1, 94, 179, 0.08),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                textColor: _hasBeenPressed2 ? Colors.white :  Color.fromRGBO(1, 94, 179, 1) ,
                onPressed: () {
                  _hasBeenPressed2 = true;
                  _hasBeenPressed = false;
                  _hasBeenPressed3 = false;
                  visibilityObs ? _changed(false, "obs") : _changed(false, "obs");
                  visibilitySeguri1 ? _changed(false, "seg1") : _changed(false, "seg1");
                  visibilitySeguri ? _changed(true, "seg") : _changed(true, "seg");
                },
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                child: Text('Cuenta', style: TextStyle(fontSize: 12.0),),
                color:  _hasBeenPressed3 ? Color.fromRGBO(1, 94, 179, 1) :  Color.fromRGBO(1, 94, 179, 0.08),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                textColor:_hasBeenPressed3 ? Colors.white :  Color.fromRGBO(1, 94, 179, 1) ,
                onPressed: () {
                  _hasBeenPressed3 = true;
                  _hasBeenPressed = false;
                  _hasBeenPressed2 = false;
                  visibilityObs ? _changed(false, "obs") : _changed(false, "obs");
                  visibilitySeguri ? _changed(false, "seg") : _changed(false, "seg");
                  visibilitySeguri1 ? _changed(true, "seg1") : _changed(true, "seg1");
                },
              ),

            ],
          ),
        ),
    new Container(
    child: new Column(
    children: <Widget>[
     if (visibilityObs) new Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                    radius: 25,
                    child: Icon(Icons.email),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, top:10, right: 0, bottom:0),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color:Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),),
                      Container(
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, top:05, right: 0, bottom:0),
                        child: Text("palmeiro.leonardo@gmail.com",style: TextStyle(fontSize: 14.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                        ),),
                    ],),
                  new Spacer(),

                  IconButton(
                      alignment: Alignment.topRight ,
                      // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                      icon: Icon(Icons.arrow_forward_ios,size: 18,),
                      onPressed: () {
                        showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                              color: Colors.white,
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[

                                    Container(
                                      margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                      alignment: Alignment.centerLeft,
                                      child: Text("Email",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 24.0),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                      child: TextField(
                                        obscureText: false,
                                        controller: emailController,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Email',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child:  FlatButton(
                                              child: Text('Aceptar', style: TextStyle(fontSize: 12.0,color: Colors.white),),
                                              color:  Color.fromRGBO(6, 16, 71, 1),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(5)),
                                              textColor: Color.fromRGBO(1, 94, 179, 1) ,
                                              onPressed: () {

                                              },
                                            ),),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                              ));},
                      ); }
                  ),
                  // ],)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                    radius: 25,
                    child: Icon(Icons.phone),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, top:10, right: 0, bottom:0),
                        child: Text(
                          'Número de teléfono',
                          style: TextStyle(
                            color:Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),),
                      Container(
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, top:05, right: 0, bottom:0),
                        child: Text("+912584444444",style: TextStyle(fontSize: 14.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                        ),),
                    ],),
                  new Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          alignment: Alignment.topRight ,
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: Icon(Icons.arrow_forward_ios,size: 18.0,),
                          onPressed: () {
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                    color: Colors.white,
                                    height: 200,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[

                                          Container(
                                            margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                            alignment: Alignment.centerLeft,
                                            child: Text("Número de teléfono",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 24.0),),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                            child: TextField(
                                              obscureText: false,
                                              controller: emailController,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Número de teléfono',
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child:  FlatButton(
                                                    child: Text('Aceptar', style: TextStyle(fontSize: 12.0,color: Colors.white),),
                                                    color:  Color.fromRGBO(6, 16, 71, 1),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(5)),
                                                    textColor: Color.fromRGBO(1, 94, 179, 1) ,
                                                    onPressed: () {

                                                    },
                                                  ),),
                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                    ));},
                            );
                          }
                      ),],)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                    radius: 25,
                    child: Image.asset('assets/images/language.png',width: 35,height: 35,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, top:10, right: 0, bottom:0),
                        child: Text(
                          'Idioma',
                          style: TextStyle(
                            color:Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),),
                      Container(
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, top:05, right: 0, bottom:0),
                        child: Text("Inglés",style: TextStyle(fontSize: 14.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                        ),),
                    ],),
                  new Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          alignment: Alignment.topRight ,
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: Icon(Icons.arrow_forward_ios,size: 18.0,),
                          onPressed: () { print("Pressed"); }
                      ),],)
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                    radius: 25,
                    child: Image.asset('assets/images/eur.png',width: 35,height: 35,),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, top:10, right: 0, bottom:0),
                        child: Text(
                          'Moneda por defecto',
                          style: TextStyle(
                            color:Color.fromRGBO(0, 0, 0, 0.5),
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                          ),
                        ),),
                      Container(
                        // alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 10, top:05, right: 0, bottom:0),
                        child: Text("EUR",style: TextStyle(fontSize: 14.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                        ),),
                    ],),
                  new Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      IconButton(
                          alignment: Alignment.topRight ,
                          // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                          icon: Icon(Icons.arrow_forward_ios,size: 18,),
                          onPressed: () { print("Pressed"); }
                      ),],)
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: OutlinedButton(
                        onPressed: (){},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 2.0,
                            color:Color.fromRGBO(1, 94, 179, 1),
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Text('Cerrar Sesión',style: TextStyle(color:Color.fromRGBO(1, 94, 179, 1),)
                        ),
                      )),
                ],
              ),
            ),
          ],
        ) ,if(visibilitySeguri) new Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                  radius: 25,
                  child: Image.asset('assets/images/key.png',width: 35,height: 35,),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, top:10, right: 0, bottom:0),
                      child: Text(
                        'Código de acceso',
                        style: TextStyle(
                          color:Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),),
                    Container(
                      // alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, top:05, right: 0, bottom:0),
                      child: Text("Último cambio hace 6 días",style: TextStyle(fontSize: 14.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                      ),),
                  ],),
                new Spacer(),

                IconButton(
                    alignment: Alignment.topRight ,
                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                    icon: Icon(Icons.arrow_forward_ios,size: 18,),
                    onPressed: () { print("Pressed"); }
                ),
                // ],)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                  radius: 25,
                  child: Image.asset('assets/images/faceid.png',width: 35,height: 35,),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, top:10, right: 0, bottom:0),
                      child: Text(
                        'Face ID',
                        style: TextStyle(
                          color:Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),),
                    Container(
                      // alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, top:05, right: 0, bottom:0),
                      child: Text("Activado",style: TextStyle(fontSize: 14.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                      ),),
                  ],),
                new Spacer(),

                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Color.fromRGBO(1, 94, 179, 1),
                  activeColor: Colors.white30,
                ),
                // ],)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 2.0,
                          color:Color.fromRGBO(1, 94, 179, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text('Cerrar Sesión',style: TextStyle(color:Color.fromRGBO(1, 94, 179, 1),)
                      ),
                    )),
              ],
            ),
          ),

        ],
      ),if(visibilitySeguri1) new Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                  radius: 25,
                  child: Image.asset('assets/images/rightsign.png',width: 35,height: 35,),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, top:10, right: 0, bottom:0),
                      child: Text(
                        'Verificación de la cuenta',
                        style: TextStyle(
                          color:Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),),
                    Container(
                      // alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, top:05, right: 0, bottom:0),
                      child: Text("Verificado",style: TextStyle(fontSize: 14.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                      ),),
                  ],),
                new Spacer(),

                IconButton(
                    alignment: Alignment.topRight ,
                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                    icon: Icon(Icons.arrow_forward_ios,size: 18,),
                    onPressed: () { print("Pressed"); }
                ),
                // ],)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Color.fromRGBO(244, 244, 244, 1),
                  radius: 25,
                  child: Image.asset('assets/images/vier.png',width: 35,height: 35,),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      // alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, top:10, right: 0, bottom:0),
                      child: Text(
                        'Métodos de pago',
                        style: TextStyle(
                          color:Color.fromRGBO(0, 0, 0, 0.5),
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),),
                    Container(
                      // alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 10, top:05, right: 0, bottom:0),
                      child: Text("Ver",style: TextStyle(fontSize: 14.00 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'TestDomaineDisplay'),
                      ),),
                  ],),
                new Spacer(),

                IconButton(
                    alignment: Alignment.topRight ,
                    // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                    icon: Icon(Icons.arrow_forward_ios,size: 18,),
                    onPressed: () { print("Pressed"); }
                ),
                // ],)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 2.0,
                          color:Color.fromRGBO(1, 94, 179, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text('Cerrar Sesión',style: TextStyle(color:Color.fromRGBO(1, 94, 179, 1),)
                      ),
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 24, top:20, right: 24, bottom:0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: OutlinedButton(
                      onPressed: (){
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                            return Container(
                                  color: Colors.white,
                                  child: Center(
                                  child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                      Container(
                                        child: Image.asset("assets/images/vectorgotoregister.png",width: 155,height: 160,),
                                      ),
                                    Container(
                                      margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                      alignment: Alignment.center,
                                      child: Text("¿Eliminar Cuenta?",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 32.0),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 24, top:0, right: 24, bottom:0),
                                      alignment: Alignment.center,
                                      child: Text("¿Estás seguro de que deseas cerrar tu cuenta de Money-4? Tu cuenta se eliminará de forma permanente.",textAlign: TextAlign.center, style: TextStyle(color: Color.fromRGBO(1, 1, 1, 0.5),fontWeight: FontWeight.normal,fontSize: 16.0),),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 24, top:10, right: 24, bottom:0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child:  FlatButton(
                                                child: Text('Si', style: TextStyle(fontSize: 12.0,color: Colors.white),),
                                                color:  Color.fromRGBO(6, 16, 71, 1),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(5)),
                                                textColor: Color.fromRGBO(1, 94, 179, 1) ,
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  },
                                              ),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 24, top:0, right: 24, bottom:0),
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: OutlinedButton(
                                                onPressed: (){
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) => EnterPhone()));                                                },
                                                style: OutlinedButton.styleFrom(
                                                  side: BorderSide(
                                                    width: 2.0,
                                                    color:Color.fromRGBO(6, 16, 71, 1),
                                                    style: BorderStyle.solid,
                                                  ),
                                                ),
                                                child: Text('No',style: TextStyle(color:Color.fromRGBO(6, 16, 71, 1),)
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),

                                    ],
                                  ),
                            ));},
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          width: 2.0,
                          color:Color.fromRGBO(1, 94, 179, 1),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text('Eliminar Cuenta',style: TextStyle(color:Color.fromRGBO(1, 94, 179, 1),)
                      ),
                    )),
              ],
            ),
          ),

        ],
      ),

      ],
    )),
   ]) );

  }


}

// enum ImageSourceType { gallery, camera }
//
// class ImageFromGalleryEx extends StatefulWidget {
//   final type;
//   ImageFromGalleryEx(this.type);
//
//   @override
//   ImageFromGalleryExState createState() => ImageFromGalleryExState(this.type);
// }
//
// class ImageFromGalleryExState extends State<ImageFromGalleryEx> {
//   var _image;
//   var imagePicker;
//   var type;
//
//   ImageFromGalleryExState(this.type);
//
//   @override
//   void initState() {
//     // ignore: todo
//     // TODO: implement initState
//     super.initState();
//     imagePicker = new ImagePicker();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: Text(type == ImageSourceType.camera
//               ? "Image from Camera"
//               : "Image from Gallery")),
//       body: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 52,
//           ),
//           Center(
//             child: GestureDetector(
//               onTap: () async {
//                 var source = type == ImageSourceType.camera
//                     ? ImageSource.camera
//                     : ImageSource.gallery;
//                 XFile image = await imagePicker.pickImage(
//                     source: source, imageQuality: 50, preferredCameraDevice: CameraDevice.front);
//                 setState(() {
//                   _image = File(image.path);
//                 });
//               },
//               child: Container(
//                 width: 200,
//                 height: 200,
//                 decoration: BoxDecoration(
//                     color: Colors.red[200]),
//                 child: _image != null
//                     ? Image.file(
//                   _image,
//                   width: 200.0,
//                   height: 200.0,
//                   fit: BoxFit.fitHeight,
//                 )
//                     : Container(
//                   decoration: BoxDecoration(
//                       color: Colors.red[200]),
//                   width: 200,
//                   height: 200,
//                   child: Icon(
//                     Icons.camera_alt,
//                     color: Colors.grey[800],
//                   ),
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

