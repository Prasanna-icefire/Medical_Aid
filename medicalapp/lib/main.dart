import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medical Aid',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
   @override
  State createState() => new LoginPageState();
}

class LoginPageState extends State<MyLoginPage> {


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children:[
            Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage("images/dark.jpg"),
              fit: BoxFit.cover, 
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            FlutterLogo(size:100),
            Form(child: Theme(
              data: ThemeData(brightness: Brightness.dark,primarySwatch: Colors.red,
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.redAccent)
              )),
                          child: Container(
                            padding: const EdgeInsets.all(40.0),
                                                      child: Column(
                children:[
                  TextFormField(decoration:InputDecoration(
                    labelText:"Enter Patient Id",
                  ),keyboardType: TextInputType.text,
                  ),
                    TextFormField(decoration:InputDecoration(
                    labelText:"Enter Password",
                  ),keyboardType: TextInputType.text,obscureText: true,
                  ),
                  Padding(padding: const EdgeInsets.only(top:20),),
                  MaterialButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text(
                      "Login"
                       ),
                       onPressed: ()=>{},
                       splashColor: Colors.red,
                  )
                ],
              ),
                          ),
            ),),

          ],
        ),
       ],
     ),
    );
  }
  
  Widget formm()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:[Form(child:
      TextFormField(
        decoration: InputDecoration(
          hintText: "Enter USN",
        ),
        keyboardType: TextInputType.text,
      ),
    ),],
    );
  }

 
 
} 