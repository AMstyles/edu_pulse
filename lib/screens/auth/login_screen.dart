import 'package:edu_pulse/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:edu_pulse/screens/auth/sign_up_screen.dart';
import 'package:edu_pulse/screens/auth/forgot_password_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../firebase/auth/auth.dart';

const enBorder = OutlineInputBorder(
  borderRadius:
  BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide(color: Colors.amber)
);

const myBorder = OutlineInputBorder(
borderRadius: BorderRadius.all(
Radius.circular(10))
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, colors: [
            Colors.orange[900]!,
            Colors.orange[800]!,
            Colors.orange[300]!,
          ])),
          child: Form(
    key: _formKey,
    child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: <Widget>[
                  Text(
                    "Edu Pulse",
                    style: GoogleFonts.abel(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                ),

                 const  SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ]),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: <Widget>[
                      const SizedBox(height: 40),
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(225, 95, 27, 0.3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              onChanged: (value) {
                                //print(value);

                                  _emailController.text = value;
                                  print(_emailController.text);

                              },
                              onEditingComplete: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },

                              decoration:const InputDecoration(
                                focusColor: Colors.amber,
                                hoverColor: Colors.amber,
                                border: myBorder,
                                enabledBorder: enBorder,
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  _passwordController.text = value;
                                });
                              },
                              obscureText: true,
                              onEditingComplete: () {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (value) {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).nextFocus();
                                }
                              },
                              decoration: const InputDecoration(
                                focusColor: Colors.amber,
                                hoverColor: Colors.amber,
                                border: myBorder,
                                enabledBorder: enBorder,
                                labelText: 'password',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty ||
                                    value.length < 6) {
                                  return 'password must be at least 6 characters long';
                                }
                                return null;
                              },
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 40,
                      ),

                      Row(
                          //crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children:[
                            const Text(
                              "Sign-Up?",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Add navigation logic here to go to another page
                                // For example, you can use Navigator.push to navigate to a new page.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUPPage()),
                                );
                              },
                              child: const Text(
                                "Click here",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                              ]),
                            GestureDetector(
                              onTap: () {
                                // Add navigation logic here to go to another page
                                // For example, you can use Navigator.push to navigate to a new page.
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassWord()),
                                );
                              },

                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),]
                            ),

                      const SizedBox(
                        height: 80,
                      ),
                      GestureDetector(
                        onTap: ()=> login(context),
                        child:
                      Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          gradient: LinearGradient(colors: [
                            Colors.orange[900]!,
                            Colors.orange[800]!,
                            Colors.orange[300]!
                          ]),
                        ),
                        child: const Center(
                            child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
          ),
        ),

    );
  }

  void login(BuildContext context) async {

    Auth.signInWithEmail(_emailController.text.trim(), _passwordController.text.trim(), context);
    // final thing = await Auth.getUID();
    // print('thing is $thing');
  }
}
