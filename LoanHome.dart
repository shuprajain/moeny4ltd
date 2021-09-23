import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _GridPerformancePage createState() => new _GridPerformancePage();
}
class _GridPerformancePage extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  String textHolder = 'Yes';
  bool _hasBeenPressed = true;
  bool _hasBeenPressed1 = false;
  bool visibilityObs = true;

  bool visibilitySeguri = false;

  void _changed(bool visibility, String field) {
    setState(() {
      if (field == "obs") {
        visibilityObs = visibility;
      }
      if (field == "seg") {
        visibilitySeguri = visibility;
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.only(left: 30, top:30, right: 30, bottom:0),
            child:SingleChildScrollView(
                child: Column(
                  // mainAxisAlignment : MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 0, top:30, right: 0, bottom:0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("Surbhi,",style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.w700,fontFamily: "TestDomaineDisplay"),textAlign: TextAlign.start,),
                                    Text("Jain",style: TextStyle(color: Colors.black,fontSize: 28,fontWeight: FontWeight.w700,fontFamily: "TestDomaineDisplay"),textAlign: TextAlign.start,),

                                  ]

                              ),
                              new Spacer(),
                              Tab(
                                icon: Badge(
                                  shape: BadgeShape.circle,
                                  badgeColor: Color.fromRGBO(255, 255, 255, 1),
                                  showBadge: true,
                                  borderRadius: BorderRadius.circular(0),
                                  position: BadgePosition.topEnd(top: 30, end: 40),
                                  padding: EdgeInsets.all(0),
                                  badgeContent: Image.asset('assets/images/badge.png'),
                                  child:   CircleAvatar(
                                    backgroundColor: Colors.white70,
                                    minRadius: 30.0,
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage:
                                      NetworkImage('https://avatars0.githubusercontent.com/u/28812093?s=460&u=06471c90e03cfd8ce2855d217d157c93060da490&v=4'),
                                    ),
                                  ),
                                ),
                              ),

                            ]
                        ),),
                      Container(
                        margin: EdgeInsets.only(left: 0, top:15, right: 0, bottom:0),

                        child: Container(
                          decoration: BoxDecoration(
                            // color: const Color(0xff7c94b6),
                            shape: BoxShape.rectangle,
                            // image: const DecorationImage(
                            //   image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                            //   fit: BoxFit.cover,
                            // ),
                            border: Border.all(
                              color: Color.fromRGBO(229, 229, 229, 1),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              SizedBox(width: 20,),
                              IconButton(
                                  alignment: Alignment.center ,
                                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                  icon: Image.asset('assets/images/bigright.png'),
                                  onPressed: () { print("Pressed"); }
                              ),
                              SizedBox(width: 5,),
                              Text("Verifica tu cuenta",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),
                              new Spacer(),
                              IconButton(
                                  alignment: Alignment.center ,
                                  // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                  icon: Icon(Icons.arrow_forward_ios),
                                  onPressed: () { print("Pressed"); }
                              ),

                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(left: 0, top:20, right: 0, bottom:0),
                      //   // width: 327,
                      //   // height: 180,
                      //   // child: Container(
                      //   //   alignment: Alignment.bottomCenter,
                      //   //   padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                      //   //   decoration: BoxDecoration(
                      //   //     // color: const Color(0xff7c94b6),
                      //   //     shape: BoxShape.rectangle,
                      //   //     gradient: LinearGradient(
                      //   //     begin: Alignment.topRight,
                      //   //     end: Alignment.bottomLeft,
                      //   //     colors: [
                      //   //       Color.fromRGBO(6, 16, 71, 1),
                      //   //       Color.fromRGBO(1, 94, 179, .5),
                      //   //     ],
                      //   //   ),
                      //   //     // image: const DecorationImage(
                      //   //     //   image: NetworkImage('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                      //   //     //   fit: BoxFit.cover,
                      //   //     // ),
                      //   //     border: Border.all(
                      //   //       width: 1,
                      //   //     ),
                      //   //     borderRadius: BorderRadius.circular(12),
                      //   //   ),
                      //   //   child : Row(
                      //   //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   //     children: <Widget>[
                      //   //       SizedBox(width: 5,),
                      //   //       Text("Préstamo Personal",style: TextStyle(fontSize: 22.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(255, 255, 255, 1),fontFamily: 'TestDomaineDisplay'),),
                      //   //       new Spacer(),
                      //   //       Container(
                      //   //         width: 67,
                      //   //         height: 38,
                      //   //         decoration: BoxDecoration(
                      //   //           shape: BoxShape.rectangle,
                      //   //           border: Border.all(
                      //   //             color: Colors.white,
                      //   //             width: 1,
                      //   //           ),
                      //   //           borderRadius: BorderRadius.circular(5),
                      //   //         ),
                      //   //
                      //   //         child : Column(
                      //   //           children: <Widget>[
                      //   //             Text("€300 a",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(255, 255, 255, 1),fontFamily: 'TestDomaineDisplay'),),
                      //   //             Text("0% Interés",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(255, 255, 255, 1),fontFamily: 'TestDomaineDisplay'),),
                      //   //
                      //   //           ],
                      //   //         )
                      //   //       )
                      //   //
                      //   //     ],
                      //   //   ),
                      //   // ),
                      //   child: Image.asset('assets/images/bg_loan.png'),
                      // ),
                      Container(
                        margin: EdgeInsets.only(left: 0, top:15, right: 0, bottom:0),
                        height: 180.0,
                        width: 627.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/s_s.png'),
                            fit: BoxFit.fill,
                          ),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left:0, top:15, right: 0, bottom:0),

                        child: Row(
                          children: <Widget>[
                            Text("Servicio",style: TextStyle(fontSize: 20.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(0, 0, 0, 0.5),fontFamily: 'SFPRODISPLAY'),),
                            new Spacer(),
                            InkWell(
                              child : Stack(
                                children: <Widget>[
                                  Visibility(
                                    visible: _hasBeenPressed,
                                    child : Text("Ver todo",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(1, 94, 179, 1),fontFamily: 'SFPRODISPLAY'),),

                                  ),
                                  Visibility(
                                      visible: _hasBeenPressed,
                                      child: Container(
                                          margin: EdgeInsets.only(left:60,right:0,top:0,bottom:0),
                                          child: Image.asset('assets/images/down_arrrow.png',width: 25,height: 25,alignment: Alignment.centerRight,)
                                      )
                                  )

                                ],
                              ),
                              onTap: (){
                                setState(() {
                                  print("+++++$_hasBeenPressed");
                                  if(_hasBeenPressed==true){
                                    _hasBeenPressed1 = true;
                                    _hasBeenPressed = false;
                                  }
                                  visibilityObs ? _changed(true, "obs") : _changed(true, "obs");
                                  visibilitySeguri ? _changed(true, "seg") : _changed(true, "seg");

                                });
                              },
                            ),
                            InkWell(
                              child:Stack(
                                children: <Widget>[
                                  Visibility(
                                    visible: _hasBeenPressed1,
                                    child : Text("Ocultar todo",style: TextStyle(fontSize: 16.0 ,fontWeight:FontWeight.normal,color: Color.fromRGBO(1, 94, 179, 1),fontFamily: 'SFPRODISPLAY'),),
                                  ),
                                  Visibility(
                                      visible: _hasBeenPressed1,
                                      child: Container(
                                          margin: EdgeInsets.only(left:90,right:0,top:0,bottom:0),
                                          child: Image.asset('assets/images/up_arrow.png',width: 25,height: 25,alignment: Alignment.centerRight,)
                                      )
                                  )
                                ],
                              ),

                              onTap: (){
                                setState(() {
                                  print("/////$_hasBeenPressed1");
                                  // _hasBeenPressed = false ;
                                  if(_hasBeenPressed1==true){
                                    _hasBeenPressed = true;
                                    _hasBeenPressed1 = false;
                                  }
                                  visibilitySeguri ? _changed(false, "seg") : _changed(false, "seg");
                                  visibilityObs ? _changed(true, "obs") : _changed(true, "obs");
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      new Container(
                      child: new Column(
                      children: <Widget>[
                      if (visibilityObs) new Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top:10, right: 0, bottom:0),
                                      width: 145,
                                      height: 70,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(244, 244, 244, 0.6),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color.fromRGBO(244, 244, 244, 0.6),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child : Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                                alignment: Alignment.center ,
                                                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                icon: Image.asset("assets/images/tips.png",width: 20,height: 20),
                                                onPressed: () { print("Pressed"); }
                                            ),
                                            Text("Límites y Tipos \n de Interés ",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),

                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top:10, right: 0, bottom:0),
                                      width: 145,
                                      height: 70,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(244, 244, 244, 0.6),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color.fromRGBO(244, 244, 244, 0.6),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child : Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                                alignment: Alignment.center ,
                                                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                icon: Image.asset("assets/images/histry.png",width: 20,height: 20),
                                                onPressed: () { print("Pressed"); }
                                            ),
                                            Text("Historial",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top:10, right: 0, bottom:0),
                                      width: 145,
                                      height: 70,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(244, 244, 244, 0.6),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color.fromRGBO(244, 244, 244, 0.6),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child : Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                                alignment: Alignment.center ,
                                                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                icon: Image.asset("assets/images/doc.png",width: 20,height: 20),
                                                onPressed: () { print("Pressed"); }
                                            ),
                                            Text("Documentos",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),

                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top:10, right: 0, bottom:0),
                                      width: 145,
                                      height: 70,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(244, 244, 244, 0.6),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color.fromRGBO(244, 244, 244, 0.6),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child : Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                                alignment: Alignment.center ,
                                                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                icon: Image.asset("assets/images/enq.png",width: 20,height: 20),
                                                onPressed: () { print("Pressed"); }
                                            ),
                                            Text("Sobre Money4",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),if(visibilitySeguri) new
                            Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top:10, right: 0, bottom:0),
                                      width: 145,
                                      height: 70,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(244, 244, 244, 0.6),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color.fromRGBO(244, 244, 244, 0.6),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child : Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                                alignment: Alignment.center ,
                                                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                icon: Image.asset("assets/images/terms.png",width: 20,height: 20),
                                                onPressed: () { print("Pressed"); }
                                            ),
                                            Text("Términos y \n Condiciones",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),

                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top:10, right: 0, bottom:0),
                                      width: 145,
                                      height: 70,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(244, 244, 244, 0.6),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color.fromRGBO(244, 244, 244, 0.6),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child : Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                                alignment: Alignment.center ,
                                                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                icon: Image.asset("assets/images/faq.png",width: 20,height: 20),
                                                onPressed: () { print("Pressed"); }
                                            ),
                                            Text("FAQ",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top:10, right: 0, bottom:10),
                                      width: 145,
                                      height: 70,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(244, 244, 244, 0.6),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color.fromRGBO(244, 244, 244, 0.6),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child : Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                                alignment: Alignment.center ,
                                                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                icon: Image.asset("assets/images/badge.png",width: 32,height: 32,),
                                                onPressed: () { print("Pressed"); }
                                            ),
                                            Text("Verificación de \n la Cuenta",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),

                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 0, top:10, right: 0, bottom:10),
                                      width: 145,
                                      height: 70,
                                      child: Container(
                                        alignment: Alignment.center,
                                        // padding: EdgeInsets.only(left:5, top:0, right: 5, bottom:15),
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(244, 244, 244, 0.6),
                                          shape: BoxShape.rectangle,
                                          border: Border.all(
                                            color: Color.fromRGBO(244, 244, 244, 0.6),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child : Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            IconButton(
                                                alignment: Alignment.center ,
                                                // Use the FaIcon Widget + FontAwesomeIcons class for the IconData
                                                icon: Image.asset("assets/images/depago.png",width: 20,height: 20),
                                                onPressed: () { print("Pressed"); }
                                            ),
                                            Text("Métodos de \n Pago",style: TextStyle(fontSize: 12.0 ,fontWeight:FontWeight.w600,color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'SFPRODISPLAY'),),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ]
                        )
                      ),
                    ]
                )
            )
        )
    );
  }


}