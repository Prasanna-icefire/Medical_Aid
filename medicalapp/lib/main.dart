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
Future navigateToSubPage(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => SubPage()));
}

class LoginPageState extends State<MyLoginPage> 
{
  String _password;
  String _patientid;
  @override
  Widget build(BuildContext context) 
  {
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

                    labelText:"Enter Name",
                  ),keyboardType: TextInputType.text,
                  onSaved:(value)=>_patientid=value,
                  ),
                    TextFormField(decoration:InputDecoration(
                    labelText:"Enter Password",
                  ),keyboardType: TextInputType.text,obscureText: true,
                  onSaved:(value)=>_password=value,
                  ),
                  Padding(padding: const EdgeInsets.only(top:20),),
                  MaterialButton(
                    color: Colors.black,
                    textColor: Colors.white,
                    child: Text(
                      "Login"
                       ),
                       onPressed: ()=>{
                         navigateToSubPage(context)
                       },
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
          hintText: "Enter Name",
        ),
        keyboardType: TextInputType.text,
      ),
    ),],
    );
  } 
}


//From here I am building the sub Page
class SubPage extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub Page'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to back to Main Page'),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.redAccent,
              child: Text('Back to Main Page'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
} 
Widget factBot(BuildContext context) {
  return Container(
    alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        materialTapTargetSize: MaterialTapTargetSize.padded,
        child: Center(
          child: Icon(Icons.chat),
        ),
        elevation: 4.0,
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.pushNamed(context, FACTS_DIALOGFLOW),
      )
  );
}

//from here the chatbot page
const String FACTS_DIALOGFLOW = "FACTS_DIALOGFLOW";

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch(routeSettings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => MyLoginPage());
      break;
    case FACTS_DIALOGFLOW:
      return MaterialPageRoute(builder: (context) => FlutterFactsDialogFlow());

  }
}


class FlutterFactsDialogFlow extends StatefulWidget {
  FlutterFactsDialogFlow({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FlutterFactsDialogFlowState createState() => new _FlutterFactsDialogFlowState();
}

class _FlutterFactsDialogFlowState extends State<FlutterFactsDialogFlow> 
{   
  final TextEditingController _textController = new TextEditingController();
    //Defining a widget here
    Widget _queryInputWidget(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _submitQuery,
                decoration: InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => _submitQuery(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }//Closing of query Input Widget


  void _submitQuery(String text) {
  _textController.clear();
  FactsMessage message = new FactsMessage(
    text: text,
    name: "Priyanka",
    type: true,
    );
  setState(() {
    _messages.insert(0, message);
    });
  _dialogFlowResponse(text);
  }
  
  final List<FactsMessage> _messages = <FactsMessage>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("When your happy and you know clap your hands!"),
      ),
      body: Column(children: <Widget>[
        Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true, //To keep the latest messages at the bottom
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            )),
        Divider(height: 1.0),
        Container(
          decoration: new BoxDecoration(color: Theme.of(context).cardColor),
          child: _queryInputWidget(context),
        ),
      ]),
    );
  }  
}
class FactsMessage extends StatelessWidget {
  FactsMessage({this.text, this.name, this.type});

  final String text;
  final String name;
  final bool type;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: this.type ? userMessage(context) : botMessage(context),
      ),
    );
  }
  List<Widget> userMessage(context) {
  return <Widget>[
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(this.name, style: Theme.of(context).textTheme.subhead),
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text(text),
          ),
        ],
      ),
    ),
    Container(
      margin: const EdgeInsets.only(left: 16.0),
      child: CircleAvatar(child: new Text(this.name[0])),
    ),
  ];
}
List<Widget> botMessage(context) {
  return <Widget>[
    Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: CircleAvatar(child: Text('Bot')),
    ),
    Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(this.name,
              style: TextStyle(fontWeight: FontWeight.bold)),
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: Text(text),
          ),
        ],
      ),
    ),
  ];
}   
} 
void _dialogFlowResponse(query) async {
  _textController.clear();
  AuthGoogle authGoogle =
  await AuthGoogle(fileJson: "assets/flutter-to-fly-creds.json").build();
  Dialogflow dialogFlow =
  Dialogflow(authGoogle: authGoogle, language: Language.english);
  AIResponse response = await dialogFlow.detectIntent(query);
  FactsMessage message = FactsMessage(
    text: response.getMessage() ??
         CardDialogflow(response.getListMessage()[0]).title,
    name: "Flutter Bot",
    type: false,
  );
  setState(() {
    _messages.insert(0, message);
  });
}

  

