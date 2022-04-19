import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'dart:convert';

String spo2="";
String hr="";
String temp="";
void fetchData() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  DatabaseReference starCountRef =
  FirebaseDatabase.instance.ref('users');
  starCountRef.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    //print(data);

    var endd = jsonDecode(jsonEncode(event.snapshot.value));
    var temp1;
    temp1 = endd[5]['temp'];
    temp=temp1.toString();
    temp1 = endd[5]['hr'];
    hr=temp1.toString();
    temp1 = endd[5]['spo2'];
    spo2=temp1.toString();

    //for(int i=1;endd[i]['age']!=-1;i++) {
    //print(endd[i]['age']);
    //var user = User();
    //user.id = endd[1]['id'];
    //userarr[0] = user;
    //print(userarr[i][1]);


    //var user1=User();
    //user1.id= endd['1'];
    //user1.age=endd['234'];
    //print(user1.age);
  } );

}
void main() async {

  fetchData();
  runApp(MyApp());
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
            Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Center(child: Column(
                children: [
                  Text("Oxygen Saturation",style: TextStyle(fontSize: 25,color:
                  Colors.black),),

                  Text(spo2,style: TextStyle(fontSize: 25,color:
                  Colors.black),),
                ],
              )),

              width: MediaQuery.of(context).size.width*0.8,
              height: MediaQuery.of(context).size.height*0.3,
              color: Colors.pink[200],),
          ],
        ),
      ),);
  }

}

// Future<void> fetchDate() async{
//   const url="https://esp32test-d9d69-default-rtdb.europe-west1.firebasedatabase.app/test.json";
//   try{
//     final http.Response res=await http.get(url);
//     print( json.decode(res.body));
//     notifyListeners();
// }catch (error){
//     throw error;
// }
// }