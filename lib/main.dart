import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:convert';
import 'dart:async';

String spo2="";
String hr="";
String temp="";
void fetchData() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
String id="4";
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
  Timer.periodic(Duration(seconds: 10), (timer) {
    fetchData();
    runApp(MyApp());
  });
}

// main(){
//   runApp(MyApp());   // الداله الي تشغل التطبيق (runapp)
//   // (myapp) اسم كلاس
// }


class MyApp extends StatefulWidget {         //(StatefulWidget) ثابته الي هي الشاشه يجري عليها تغييرات jUI ميخلي ال

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home:Home(),        // استدعاء للكلاس
    );
  }
}
class Home extends StatelessWidget{
  @override
  // void initState(){
  //   Provider.of<Products>(context,listen:false).fetchDate();
  //   super.initState();
  // }
  Widget build(BuildContext context) {
    print(temp);
    return  Scaffold(backgroundColor: Colors.white,     //Scaffold الواجهة
      appBar: AppBar(title: Text("Information View"),),  //appBar الشريط الازرق
      body: Container(                                     //body من الشريط الازرق وجوة
        width: double.infinity,margin: EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(width: MediaQuery.of(context).size.width*0.4,color: Colors.blue[200],
                  height: MediaQuery.of(context).size.height*0.2,
                  margin: EdgeInsets.only(right: 2.5),

                  child: Center(child: Column(
                    children: [
                      Text("Heart Rate",style:  TextStyle(fontSize: 25,color:
                      Colors.black),),
                      Text(hr,style:  TextStyle(fontSize: 25,color:
                      Colors.black),),
                    ],
                  )),
                ),
                Container(width: MediaQuery.of(context).size.width*0.4,color: Colors.grey[300],
                  height: MediaQuery.of(context).size.height*0.2,
                  margin: EdgeInsets.only(left: 2.5),

                  child: Center(child: Column(
                    children: [
                      Text("temperature ",style: TextStyle(fontSize:25,color:
                      Colors.black),),

                      Text(temp,style: TextStyle(fontSize: 25,color:
                      Colors.black),),
                    ],
                  )),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(child: Column(
                children: [
                  Text("Oxygen Saturation",style: TextStyle(fontSize: 25,color:
                  Colors.black),),

                  Text(spo2,style: TextStyle(fontSize: 25,color:
                  Colors.black),),
                ],
              )),

              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.2,
              color: Colors.pink[200],),Container(margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Center(child: Column(
                children: [TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term',
                  ),
                ),
                ],
              )),
            )
          ],
        ),
      ),);
  }

}
