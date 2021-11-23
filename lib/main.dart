import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PassGen",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var pass;
  var txt = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getPass();

  }

  void getPass () async {
    http.Response response = await dataHTTP();
    pass = response.body.toString();
    txt.text = pass;
    print(pass);

  }

  Future<http.Response> dataHTTP() async {
    return http.get(
      Uri.parse(
        ('https://pass-gen-api.herokuapp.com/api/generate'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Passgen"),),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  "Generate a random password",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.black
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: txt,
                        decoration: InputDecoration(
                          labelText: 'Label text',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Respond to button press
                      },

                      icon: Icon(Icons.cut, size: 18),
                      label: Text("Copy"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


