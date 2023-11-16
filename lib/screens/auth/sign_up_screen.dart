import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../firebase/auth/auth.dart';
import '../../firebase/data/data.dart';
import '../../models/local_user.dart';
import '../../services/local_storage_services.dart';
import '../../services/local_user_provider.dart';
import '../home_screen.dart';

class SignUPPage extends StatefulWidget {
  const SignUPPage({super.key,});

  @override
  State<SignUPPage> createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUPPage> {

  final _formKey = GlobalKey<FormState>();
  final _nameFieldKey = GlobalKey<FormFieldState>();
  final _emailFieldKey = GlobalKey<FormFieldState>();
  final _passwordFieldKey = GlobalKey<FormFieldState>();
  final _confirmPasswordFieldKey = GlobalKey<FormFieldState>();
  final _choiceFieldKey = GlobalKey<FormFieldState>();

  String? userType;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  final enBorder = const OutlineInputBorder(
  borderRadius:
  BorderRadius.all(Radius.circular(10)),
  borderSide: BorderSide(color: Colors.amber),
  );

  final myBorder = const OutlineInputBorder(
  borderRadius: BorderRadius.all(
  Radius.circular(10)),



  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[900]!,
              Colors.orange[800]!,
              Colors.orange[300]!,
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Let`s get you started!",
                      style: GoogleFonts.abel(color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 6,
                        ),

                        Padding(padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            key: _nameFieldKey,
                            onChanged: (value) {
                              setState(() {
                                _nameController.text = value;
                              });
                            },
                            onEditingComplete: () {
                              if (_nameFieldKey.currentState!.validate()) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            decoration:  InputDecoration(
                              focusColor: Colors.amber,
                              hoverColor: Colors.amber,
                              border: myBorder,
                              enabledBorder: enBorder,
                              labelText: 'Full names',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                        ),

                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () {
                              if (_emailFieldKey.currentState!.validate()) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            key: _emailFieldKey,
                            onChanged: (value) {
                              setState(() {
                                _emailController.text = value;
                              });
                            },

                            decoration:InputDecoration(
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
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            key: _passwordFieldKey,
                            onChanged: (value) {
                              setState(() {
                                _passwordController.text = value;
                              });
                            },
                            obscureText: true,
                            onEditingComplete: () {
                              if (_passwordFieldKey.currentState!.validate()) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              if (_passwordFieldKey.currentState!.validate()) {
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            decoration: InputDecoration(
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
                        const SizedBox(
                          height: 7,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: TextFormField(
                            key: _confirmPasswordFieldKey,
                            onChanged: (value) {
                              setState(() {
                                _confirmPasswordController.text = value;
                              });
                              _confirmPasswordFieldKey.currentState!.validate();
                            },
                            decoration: InputDecoration(
                              focusColor: Colors.amber,
                              hoverColor: Colors.amber,
                              border: myBorder,
                              enabledBorder: enBorder,
                              labelText: 'confirm password',
                            ),
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        _buildChoiceUser(),
                        const SizedBox(
                          height: 7,
                        ),
                        GestureDetector(
                          onTap: () {
                            _formKey.currentState!.validate()? submit(): null;
                          },
                          child:
                          Container(
                            padding: const EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(colors: [
                                Colors.orange[900]!,
                                Colors.orange[800]!,
                                Colors.orange[300]!,
                              ]),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                )
                              ],
                            ),
                            margin: const EdgeInsets.all(10),
                            child: const Text(
                              'Signup',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildChoiceUser() {
    //return row of choice chips one with user and other with moderator
    return Padding(padding: const EdgeInsets.all(10),
      child: FormField(
          key: _choiceFieldKey,
          validator: (value) {
            if (userType == null) {
              return 'Please select a user type';
            }
            return null;
          }, builder: (FormFieldState state) {
        return Container(padding: const EdgeInsets.only(top: 5),
          child: InputDecorator(decoration: InputDecoration(
            labelText: 'Choose User Type',
            errorText: state.errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChoiceChip(
                  label: const Text('Student'),
                  selected: userType == 'student',
                  onSelected: (selected) {
                    HapticFeedback.lightImpact();
                    setState(() {
                      userType = 'student';
                    });
                  },
                ),
                ChoiceChip(label: const Text('Admin'),
                  selected: userType == 'admin',
                  onSelected: (selected) {
                    HapticFeedback.lightImpact();
                    setState(() {
                      userType = 'admin';
                    });
                  },
                ),
              ],
            ),
          ),);
      }),);
  }

  void submit() async {
    String value = await Auth.signupWithEmail(
        context, _emailController.text.trim(), _passwordController.text.trim());

    if (value.toString() == 'success') {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value),));
      LocalUser user = LocalUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        isStudent: userType == 'student' ? true : false,
        faculty: 'haha',
      );
      await Database.writeUser(user, context);
      // //set user in provider
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      LocalStorage.writeUserToLocalStorage(user);
      print(Provider.of<UserProvider>(context, listen: false).user!.toString());
      MaterialPageRoute route = MaterialPageRoute(builder: (context) => const HomePage(), settings: const RouteSettings(name: 'HomePage'));
      Navigator.pushReplacement(context, route);
    }
    else {
      //show snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(value),));
    }
  }


}
