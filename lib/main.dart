import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'splash.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: SplashScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  var result;
  var gender;

  Future<void> predictGender(String name) async {
    try {
      var url = "https://api.genderize.io/?name=$name";
      var res = await http.get(Uri.parse(url));

      if (res.statusCode == 200) {
        // Successfully fetched data
        var body = json.decode(res.body);
        var gender = body['gender'];
        var prob = body['probability'];
        result = "Gender: ${gender.toUpperCase()} \n Probability: $prob";

        setState(() {});
      } else {
        print("Failed to fetch data. Status code: ${res.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          "Gender Predictor",
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 0, 102)),
        )),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                'https://img.pikbest.com/wp/202343/abstract-brush-strokes-soft-on-paper-pastel-pink-blue-and-white-background_9979854.jpg!sw800',
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Enter a name to predict its gender",
                  style: GoogleFonts.raleway(
                    color: Colors.blueGrey[800],
                    fontSize: 24,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextField(
                    controller: _nameController,
                    style: GoogleFonts.raleway(
                        color: Colors.black,
                        fontSize: 20), // Adjust the font size
                    decoration: InputDecoration(
                      hintText: "Name",
                      hintStyle: GoogleFonts.raleway(fontSize: 20),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.purple,
                          width: 2.0,
                        ), // Adjust border color and thickness
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueGrey,
                          width: 2.0,
                        ), // Adjust border color and thickness
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () => predictGender(_nameController.text),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Predict",
                        style: GoogleFonts.raleway(
                            color: Colors.purple, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                if (result != null)
                  Text(
                    result,
                    style: GoogleFonts.raleway(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
