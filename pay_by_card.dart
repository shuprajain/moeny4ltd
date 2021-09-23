// // TODO Implement this library.
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:crypto/crypto.dart';
// import 'package:flutter_ip/flutter_ip.dart';
// import 'package:http/http.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
//
//
//
// import 'package:money4/api_exceptions.dart';
// import 'package:money4/main.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import 'SharedPreferencesHelper.dart';
//
// class PayByCard extends StatefulWidget {
//
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<PayByCard> {
//
//   String _internalIP = 'Unknown';
//   Future<WebViewController> controller;
//   String redirect = '';
//   final Completer<WebViewController> _controller =
//   Completer<WebViewController>();
//   TextEditingController client_orderid = TextEditingController();
//   TextEditingController order_desc = TextEditingController();
//   TextEditingController first_name = TextEditingController();
//   TextEditingController last_name = TextEditingController();
//   TextEditingController address1 = TextEditingController();
//   TextEditingController city = TextEditingController();
//   TextEditingController state = TextEditingController();
//   TextEditingController zip_code = TextEditingController();
//   TextEditingController country = TextEditingController();
//   TextEditingController phone = TextEditingController();
//   TextEditingController email = TextEditingController();
//   TextEditingController amount = TextEditingController();
//   TextEditingController currency = TextEditingController();
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Card Verification')),
//         body: Padding(
//             padding: EdgeInsets.all(10),
//             child: ListView(
//               children: <Widget>[
//
//                 Container(
//                   padding: EdgeInsets.all(10),
//                   child: TextField(
//                     controller: client_orderid,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'client_orderid',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: order_desc,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'order_desc',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: first_name,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'first_name',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: last_name,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'last_name',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: address1,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'address1',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: city,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'city',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: state,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'state',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: zip_code,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'zip_code',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: country,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'country',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: phone,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'phone',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: email,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'email',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: amount,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'amount',
//                     ),
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
//                   child: TextField(
//                     controller: currency,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       labelText: 'currency',
//                     ),
//                   ),
//                 ),
//
//                 Container(
//                     child: TextButton(
//                       style: ButtonStyle(
//                         foregroundColor: MaterialStateProperty.all<Color>(
//                             Colors.blue),
//                       ),
//                       onPressed: () {
//                         _callApi(context);
//                       },
//                       child: Text('Submit'),
//                     ))
//               ],
//             )));
//   }
//
//
//   void find_sha1() {
//     // print(textS+"   ***********************  ");
// //    $('#outputtextarea').val(text);
//   }
//
//   CardRef(BuildContext context) async {
//     SharedPreferences myPrefs = await SharedPreferences.getInstance();
//     int orderid = myPrefs.getInt("orderid");
//     var bytes1 = utf8.encode(
//         "sbox-money4" + client_orderid.text.toString() + orderid.toString() +
//             "09098D19-A2A8-4E87-B8B7-C4E271C32708");
//     var digest = sha1.convert(bytes1);
//     print(digest);
//     String client_orderid1 = client_orderid.text;
//
//
//     post(
//         "https://sandbox.payneteasy.eu/paynet/api/v2/create-card-ref/4960?login=sbox-money4&client_orderid=$client_orderid1&orderid=$orderid&control=$digest")
//         .then((r) async {
//       print(r.statusCode); //
//       print(r.body);
//       if (r.statusCode == 200) {
//         String s = ((r.body).replaceAll("=", ":"));
//         print(s.split("&"));
//         List<String> k = s.split("&");
//         String redirect = k.elementAt(2).replaceAll("card-ref-id:", "");
//         print(redirect);
//         myPrefs.setInt('card_ref_id', int.parse(redirect));
//         SerachZohoContact(context,email.text,redirect);
//       }
//     });
//   }
//
//   _callApi(BuildContext context) async {
//     String am = amount.text;
//     int amt = int.parse(am);
//     amt = amt * 100;
//     var bytes1 = utf8.encode(
//         "4960" + client_orderid.text.toString() + amt.toString() +
//             email.text.toString() + "09098D19-A2A8-4E87-B8B7-C4E271C32708");
//     print("4960" + client_orderid.text + amt.toString() + email.text +
//         "09098D19-A2A8-4E87-B8B7-C4E271C32708"); // data being hashed
//     var digest = sha1.convert(bytes1);
//     print(digest);
//     String client_orderid1 = client_orderid.text;
//     String order_desc1 = order_desc.text;
//     String first_name1 = first_name.text;
//     String last_name1 = last_name.text;
//     String address11 = address1.text;
//     String city1 = city.text;
//     String state1 = state.text;
//     String zip_code1 = zip_code.text;
//     String country1 = country.text;
//     String phone1 = phone.text;
//     String email1 = email.text;
//     String amount1 = amount.text;
//     String currency1 = currency.text;
//     // String internal = await FlutterIp.internalIP;
// //&redirect_url=https://crm-masters.com/
//     post(
//         "https://sandbox.payneteasy.eu/paynet/api/v2/preauth-form/4960?client_orderid=$client_orderid1&order_desc=$order_desc1&first_name=$first_name1&last_name=$last_name1&address1=$address11&city=$city1&state=$state1&zip_code=$zip_code1&country=$country1&phone=$phone1&email=$email1&amount=$amount1&currency=$currency1&ipaddress=162.210.194.37&control=$digest&redirect_success_url=https://sandbox.payneteasy.eu/paynet/form/payment&redirect_fail_url=https://crm-masters.com/contact-us/")
//         .then((r) async {
//       print(r.statusCode); //
//       // print((r.body));//
//
//       if (r.statusCode == 200) {
//         // i think there is some class for this..please wait
//         // can i start work on UI and then will this ?
//         // there is a function in dio library for this...do you want to try that?
//         //ok
//         String s = ((r.body).replaceAll("=", ":"));
//         // s = s.replaceAll("=", ":");
//         print(s.split("&"));
//         List<String> k = s.split("&");
//         redirect = k.elementAt(4).replaceAll("redirect-url:", "");
//         redirect = redirect.replaceAll("%3A", ":");
//         redirect = redirect.replaceAll("%2F", "/");
//         print(redirect); //this one
//         String orderid = k.elementAt(3).replaceAll("paynet-order-id:", "");
//         SharedPreferences myPrefs = await SharedPreferences.getInstance();
//         myPrefs.setInt('orderid', int.parse(orderid));
//         // if( json.decode(r.body)["status"]=="success"){
//         //   // StorageUtil.setDouble("value",0.0);
//         // child: FutureBuilder<dynamic>(
//         //     future: _launchURL(redirect),
//         //     builder: (context, snapshot) {
//         //
//         //       return CircularProgressIndicator();
//         //     }
//         // );
//
//         Navigator.of(context).push(MaterialPageRoute(
//             builder: (BuildContext context) =>
//                 InAppWebView(
//                   initialUrlRequest: URLRequest(url: Uri.parse(redirect)),
//                   initialOptions: InAppWebViewGroupOptions(
//                     crossPlatform: InAppWebViewOptions(
//                       preferredContentMode: UserPreferredContentMode.DESKTOP,
//                     ),
//                   ),
//
//                   onWebViewCreated: (
//                       InAppWebViewController webViewController) async {
//                     controller = webViewController as Future<WebViewController>;
//                   },
//
//                   onLoadStart: (InAppWebViewController controller, Uri url) {
//                     print("Loading $url...");
//                   },
//
//                   onLoadStop: (InAppWebViewController controller,
//                       Uri url) async {
//                     print('$url' ==
//                         ('https://sandbox.payneteasy.eu/paynet/wait/4960/$orderid')
//                             .trim()); // true, contain the same characters
//                     print(identical('$url',
//                         'https://sandbox.payneteasy.eu/paynet/form/payment'));
//                     if ('$url' ==
//                         ('https://sandbox.payneteasy.eu/paynet/wait/4960/$orderid')
//                             .trim()) {
//                       print("Loaded $url.");
//                       print(url.data);
//                       CardRef(context);
//
//                     }
//                   },
//
//                 )));
//       }
//     });
//   }
//
//   Future<http.Response> post(String url) async {
//     try {
//       Uri myUri = Uri.parse(url);
//       final response = await http.post(myUri);
//       return response;
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//   }
//
//   _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       //   CardRef(context);
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   Future<void> _updateInternalIP() async {
//     String ip;
//     try {
//       ip = await FlutterIp.internalIP;
//     } on PlatformException {
//       ip = 'Failed to get ip.';
//     }
//     if (!mounted) return;
//
//     setState(() {
//       _internalIP = ip;
//     });
//   }
//
//   Future<http.Response> postZohoToken(String url) async {
//     print('Api Get, url $url');
//     var headers = {
//       'Content-Type': 'application/x-www-form-urlencoded'
//     };
//     var responseJson;
//     try {
//       Uri myUri = Uri.parse(url);
//       final response = await http.post(myUri, headers: headers,
//           body: {
//             "client_id": "1000.ZYILRWIHMWKO36Q58LCB4U74JCMQVV",
//             "client_secret": "5f770f05bf4b46421376d8934687c4f76a4479372c",
//             "refresh_token": "1000.e2f71da32c5e602609631be1792533cf.4764d8261ac06d3c591db92297018e76",
//             "grant_type": "refresh_token"
//           }); //
//       return response;
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//   }
//
//   Future<http.Response> get(String url) async {
//     print('Api Get, url $url');
//     SharedPreferences myPrefs = await SharedPreferences.getInstance();
//
//     var headers = {
//       'authorization': 'Zoho-oauthtoken ' + myPrefs.getString('header')
//     };
//     var responseJson;
//     try {
//       Uri myUri = Uri.parse(url);
//       final response = await http.get(myUri,
//           headers: headers); //,body: json.encode({"someParam": 123, "anotherOne": "Hello World"})
//       return response;
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//   }
//   Future<http.Response> put(String url,dynamic body) async {
//     print('Api Get, url $url');
//     SharedPreferences myPrefs = await SharedPreferences.getInstance();
//
//     var headers = {
//       'authorization': 'Zoho-oauthtoken ' + myPrefs.getString('header')
//     };
//     var responseJson;
//     try {
//       Uri myUri = Uri.parse(url);
//       final response = await http.put(myUri,
//           headers: headers,
//       body:body ); //,body: json.encode({"someParam": 123, "anotherOne": "Hello World"})
//       return response;
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//   }
//   Future<http.Response> postRecord(String url,dynamic body) async {
//     print('Api Get, url $url');
//     SharedPreferences myPrefs = await SharedPreferences.getInstance();
//
//     var headers = {
//       'authorization': 'Zoho-oauthtoken ' + myPrefs.getString('header')
//     };
//     var responseJson;
//     try {
//       Uri myUri = Uri.parse(url);
//       final response = await http.post(myUri,
//           headers: headers,
//           body:body ); //,body: json.encode({"someParam": 123, "anotherOne": "Hello World"})
//       return response;
//     } on SocketException {
//       print('No net');
//       throw FetchDataException('No Internet connection');
//     }
//   }
//   SerachZohoContact(BuildContext context, String name,String card_ref_id) {
//     postZohoToken("https://accounts.zoho.eu/oauth/v2/token").then((r) async {
//       print(r.statusCode); //
//       print(json.decode(r.body)["access_token"]);
//       SharedPreferences myPrefs = await SharedPreferences.getInstance();
//       myPrefs.setString('header', json.decode(r.body)["access_token"]);
//
//
//       get("https://www.zohoapis.eu/crm/v2/Contacts/search?criteria=((Email:equals:" + name + "))").then((r) {
//         print(r.statusCode); //
//         // print(json.decode(r.body));//
//         if (r.statusCode == 200) {
//           // get("https://www.zohoapis.eu/crm/v2/Contacts/search?criteria=((Password:equals:"+pass+"))").then((r){
//           if (r.statusCode == 200) {
//             print(json.decode(r.body)["data"]);
//             StorageUtil.setString(
//                 "ContactID", (json.decode(r.body)["data"][0]["id"]));
//             dynamic body = jsonEncode({
//               "data": [
//                 {
//                   "Name":card_ref_id,//"surbhi.jain@gmail.com"  CardRefIds
//                   "Contacts":json.decode(r.body)["data"][0]["id"],
//                 }
//               ]
//
//             });
//             StorageUtil.setString(
//                 "First_Name", (json.decode(r.body)["data"][0]["First_Name"]));
//             StorageUtil.setString(
//                 "Last_Name", (json.decode(r.body)["data"][0]["Last_Name"]));
//             //   StorageUtil.setInt("ContactIDInt", (json.decode(r.body)["data"][0]["id"]));
//             postRecord("https://www.zohoapis.eu/crm/v2/CardRefIds",body).then((value) {
//               if (value.statusCode == 200) {
//                 print("Contactr is updated"+json.decode(r.body)["data"]["id"]);
//               }
//             });
//             // put("https://www.zohoapis.eu/crm/v2/Contacts/"+json.decode(r.body)["data"][0]["id"], body).then((value) {
//             //   if (value.statusCode == 200) {
//             //     print("Contactr is updated"+json.decode(r.body)["data"][0]["id"]);
//             //   }
//             // });
//
//             // Navigator.push(
//             //     context, MaterialPageRoute(builder: (context) => MyHomePage()));
//           } else {
//             Fluttertoast.showToast(
//                 msg: "Password is not matched",
//                 toastLength: Toast.LENGTH_SHORT,
//                 gravity: ToastGravity.CENTER,
//                 timeInSecForIosWeb: 1,
//                 backgroundColor: Colors.white,
//                 textColor: Colors.black,
//                 fontSize: 16.0
//             );
//           }
//           // });
//         }
//       });
//     });
//   }
// }
//
//
