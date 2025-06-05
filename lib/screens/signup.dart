import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jansuraksha/screens/home.dart';
import 'package:jansuraksha/screens/login.dart';
import 'package:jansuraksha/services/authentication.dart';
import 'package:jansuraksha/widgets/circular_icon.dart';
import 'package:jansuraksha/widgets/textfield.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true, 
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              SizedBox(
                height: size.height / 2.4,
                width: double.infinity,
                //color: Colors.amber,
                child: Image.asset("assets/intro1.png", fit: BoxFit.cover),
              ),
              Positioned(
                top: size.height / 3,
                left: 0,
                right: 0,
                bottom: 0,
                child: KeyboardAvoider(
                  autoScroll: true,
                  child: Container(
                    height: size.height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: const Color.fromARGB(255, 238, 238, 237),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Text(
                            "SignUp",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(height: 15),
                          CircularIconButton(imagePath: "assets/image.png"),
                          SizedBox(height: 15),
                          Text(
                            "OR",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 15),
                          TextFieldWidget(
                            controller: nameController,
                            text: "Enter your name",
                            filled: false,
                          ),
                          SizedBox(height: 15),
                          TextFieldWidget(
                            controller: emailController,
                            text: "Enter your email",
                            filled: false,
                          ),
                          SizedBox(height: 15),
                          TextFieldWidget(
                            controller: passwordController,
                            text: "Enter password",
                            filled: false,
                          ),
                          SizedBox(height: 5),
                  
                          SizedBox(height: 15),
                          Button(
                            nameController: nameController,
                            emailController: emailController,
                            passwordController: passwordController,
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account ?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Login(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
}

class Button extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  const Button({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool circular = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        
        setState(() {
          circular = true;
        });
        String res = await Authentication().signup(
          email: widget.emailController.text,
          password: widget.passwordController.text,
        );
        
        setState(() {
          circular = false;
        });
        if (res == 'Success') {
          await FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({"name": widget.nameController.text});

          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Home()),
            (route) => false,
          );
        } else {
          SnackBar sb = SnackBar(content: Text(res));
          ScaffoldMessenger.of(context).showSnackBar(sb);
        }
      },
      style: ElevatedButton.styleFrom(
        // Add your style properties here, for example:
        minimumSize: Size(double.infinity, 50),
        backgroundColor: const Color.fromARGB(255, 234, 37, 60),
        foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Text(
        "SignUp",
        style: TextStyle(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontSize: 23,
        ),
      ),
    );
  }
}
