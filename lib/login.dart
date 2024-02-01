import 'package:bloobak/mainscreen.dart';
import 'package:bloobak/screen1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  var password = prefs.getString("password");
  print(email);
  print(password);
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: email == null ? login() : MainScreen(),
  ));
}

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController controller = TextEditingController();
  TextEditingController pcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? validatePassword(String value) {
    RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/blood.png",
            height: 120,
            width: 150),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (String? value) {
                  return (value!.length == 0) ? 'please fill this field' : null;
                },
                controller: controller,
                decoration: InputDecoration(
                    hintText: "Email", border: OutlineInputBorder()),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (String? value) {
                  return validatePassword(value!);
                },
                controller: pcontroller,
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password", border: OutlineInputBorder()),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState!.validate()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("email", controller.text.toString());
                    prefs.setString("password", pcontroller.text.toString());
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Screen1(),
                        ));
                    Fluttertoast.showToast(
                      msg: "Login Sucessfull",
                      gravity: ToastGravity.BOTTOM,
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
