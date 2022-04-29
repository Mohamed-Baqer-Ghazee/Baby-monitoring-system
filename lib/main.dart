import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:convert';
import 'dart:async';

bool _secureText = true;
String spo2="SpO2";
String hr="HR";
String temp="Temp";
String id="4";

TextEditingController _nameController =TextEditingController();
void fetchData() async{
  print("temp: "+temp);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DatabaseReference starCountRef =
  FirebaseDatabase.instance.ref('users/'+id);
  starCountRef.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    //print(data);

    var endd = jsonDecode(jsonEncode(event.snapshot.value));
    print(endd);
    var temp1;
    temp1 = endd['temp'];
    temp=temp1.toString();
    temp1 = endd['hr'];
    hr=temp1.toString();
    temp1 = endd['spo2'];
    spo2=temp1.toString();
  } );

}
void main() async {
  Timer.periodic(Duration(seconds: 7), (timer) {
    fetchData();
    runApp(MyApp());
  });
}


class MyApp extends StatelessWidget {         //(StatefulWidget) ثابته الي هي الشاشه يجري عليها تغييرات jUI ميخلي ال

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home:const _MyAppState(title: 'Flutter Demo Home Page'),        // استدعاء للكلاس
    );
  }
}

class _MyAppState extends StatefulWidget {
  final String title;

  const _MyAppState({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Home createState() => Home();
}
class Home extends State<_MyAppState>{
  @override

  Widget build(BuildContext context) {

    print("temp: "+temp);
    return  Scaffold(backgroundColor: Colors.grey[150],     //Scaffold الواجهة
      appBar: AppBar(title: Text("Information View"),backgroundColor: Colors.blue[200]),  //appBar الشريط الازرق
      body: Container(                                     //body من الشريط الازرق وجوة
        width: double.infinity,margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height*0.6,
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Center(
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter Your ID',
                            labelText: "iD",
                            errorText: null,
                            suffixIcon: IconButton(
                              icon: Icon(_secureText ? Icons.remove_red_eye: Icons.security),
                              onPressed: (){
                                setState((){
                                  _secureText = !_secureText;
                                });
                              },
                            ),
                            labelStyle: TextStyle(
                                fontSize: 25,
                                color: Colors.black38
                            )
                          //border:OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        obscureText:  _secureText ,
                      ),
                      RaisedButton(onPressed: (){
                        print("ID" + _nameController.text);
                        id=_nameController.text;

                      }
                      )
                    ],
                  )),
              width: MediaQuery.of(context).size.width * 0.8,
              color: Colors.blue[100],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width*0.39,
                  color: Colors.blueAccent[100],
                  height: MediaQuery.of(context).size.height*0.15,
                  margin: EdgeInsets.only(right: 2.5),

                  child: Center(child: Column(
                    children: [
                      Text("Heart Rate",
                        style:  TextStyle(fontSize: 25,
                            color:Colors.grey[100]),),
                      Text(hr,
                        style:  TextStyle(fontSize: 25,
                            color: Colors.grey[100]),),
                    ],
                  )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.39,
                  color: Colors.blueAccent[100],
                  height: MediaQuery.of(context).size.height*0.15,
                  margin: EdgeInsets.only(left: 2.5),
                  child: Center(child: Column(
                    children: [
                      Text("Temperature ",
                        style: TextStyle(fontSize:25,
                            color: Colors.grey[100]),),

                      Text(temp,
                        style: TextStyle(fontSize: 25,
                            color:Colors.grey[100]),),
                    ],
                  )),
                ),
              ],
            ),
            Container(margin: EdgeInsets.fromLTRB(0, 5, 0, 10),
              child: Center(child: Column(
                children: [
                  Text("Oxygen Saturation",style: TextStyle(fontSize: 25,color:
                  Colors.grey[100]),),

                  Text(spo2,style: TextStyle(fontSize: 25,color:
                  Colors.grey[100]),),
                ],
              )),

              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.15,
              color: Colors.blueAccent[100],),
          ],
        ),
      ),);
  }
}
