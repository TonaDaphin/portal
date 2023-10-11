import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:requests_portal/login.dart';
import 'package:requests_portal/signup.dart';
import 'package:requests_portal/test.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // addTask(name: ' kankwamnzi tona');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Request Portal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 166, 18, 31),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
            const Text(
              'REQUEST PORTAL',
              style: TextStyle(
                  color: Color.fromARGB(255, 166, 18, 31),
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: const ButtonStyle(),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Color.fromARGB(255, 166, 18, 31),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 166, 18, 31))),
                child: const Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomepage(),
//     );
//   }
// }
// class MyHomepage extends StatefulWidget {
//   const MyHomepage({Key? key}) : super(key: key);
//   @override
//   State<MyHomepage> createState() => _MyHomepageState();
// }
// class _MyHomepageState extends State<MyHomepage> {
//   final _formKey = GlobalKey<FormState>();
//   // regular expression to check if string
//   RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
//   double password_strength = 0; 
//    // 0: No password
//   // 1/4: Weak
//   // 2/4: Medium
//   // 3/4: Strong
//   //   1:   Great
//   //A function that validate user entered password
//   bool validatePassword(String pass){
//     String _password = pass.trim();
//     if(_password.isEmpty){
//       setState(() {
//         password_strength = 0;
//       });
//     }else if(_password.length < 6 ){
//       setState(() {
//         password_strength = 1 / 4;
//       });
//     }else if(_password.length < 8){
//       setState(() {
//         password_strength = 2 / 4;
//       });
//     }else{
//       if(pass_valid.hasMatch(_password)){
//         setState(() {
//           password_strength = 4 / 4;
//         });
//         return true;
//       }else{
//         setState(() {
//           password_strength = 3 / 4;
//         });
//         return false;
//       }
//     }
//     return false;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: TextFormField(
//                   onChanged: (value){
//                     _formKey.currentState!.validate();
//                   },
//                   validator: (value){
//                       if(value!.isEmpty){
//                         return "Please enter password";
//                       }else{
//                        //call function to check password
//                         bool result = validatePassword(value);
//                         if(result){
//                           // create account event
//                          return null;
//                         }else{
//                           return " Password should contain Capital, small letter & Number & Special Character";
//                         }
//                       }
//                   },
//                   decoration: InputDecoration(border: OutlineInputBorder(),hintText: "Password"),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(12.0),
//                 child: LinearProgressIndicator(
//                   value: password_strength,
//                   backgroundColor: Colors.grey[300],
//                   minHeight: 5,
//                   color: password_strength <= 1 / 4
//                       ? Colors.red
//                       : password_strength == 2 / 4
//                       ? Colors.yellow
//                       : password_strength == 3 / 4
//                       ? Colors.blue
//                       : Colors.green,
//                 ),
//               ),
//               ElevatedButton(onPressed: password_strength != 1 ? null : (){
//                 //perform click event
//               }, child: Text("Submit form"))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }