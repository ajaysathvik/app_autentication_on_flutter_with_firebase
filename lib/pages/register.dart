import 'package:chatapp_firebase/helper/helper_function.dart';
import 'package:chatapp_firebase/pages/home_page.dart';
import 'package:chatapp_firebase/pages/login_page.dart';
import 'package:chatapp_firebase/services/auth_services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../widjets/widgets.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  bool _isloading = false;
  final formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isloading
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Babble",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Login Now To See What They Are Talking!!",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.white60),
                        ),
                        Image.asset(
                            '/home/ajay/chatapp_firebase/chatapp_firebase/assets/register.png'),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: "username",
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              )),
                          onChanged: (val) {
                            setState(() {
                              fullName = val;
                            });
                          },
                          validator: (val) {
                            if (val!.isNotEmpty) {
                              return null;
                            } else {
                              return "Name Cannot Be Empty";
                            }
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                            labelText: "Email",
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Colors.white,
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              email = val;
                            });
                          },
                          validator: (val) {
                            return RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val!)
                                ? null
                                : "Please Enter a Valid Email";
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                            obscureText: true,
                            decoration: textInputDecoration.copyWith(
                              labelText: "password",
                              prefixIcon: const Icon(
                                Icons.key,
                                color: Colors.white,
                              ),
                            ),
                            validator: (val) {
                              if (val!.length < 4) {
                                return "enter a stronger password";
                              } else {
                                return null;
                              }
                            },
                            onChanged: (val) {
                              setState(() {
                                password = val;
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColorDark,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30))),
                            child: const Text("Register",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
                            onPressed: () {
                              register();
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text.rich(TextSpan(
                            text: "Already Have An Account?  ",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 14),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Login Now",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      nextscreen(context, const LoginPage());
                                    })
                            ]))
                      ],
                    )),
              ),
            ),
    );
  }

  register() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(fullName, email, password)
          .then((value) async{
            if (value==true){
              //saving the shared preference state
              await HelperFunctions.saveUserLoggedInStatus(true);
              await HelperFunctions.saveUserEmailSF(email);
              await HelperFunctions.saveUserNameSF(fullName);
              nextscreenreplacement(context, const HomePage());
              }
            else{
              showSnackBar(context,Colors.red,value);
              setState(() {
                _isloading =false;
              });
            }  
          });
    }
  }
}
