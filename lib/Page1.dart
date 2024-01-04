import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class New_App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationForm(),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController panController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();

  void _submitForm() async {
    // Get the current location
    Location location = Location();
    await location.requestPermission();
    LocationData currentLocation = await location.getLocation();

    // Define the data for the POST request
    Map<String, dynamic> requestData = {
      "mobile": mobileController.text,
      "email": emailController.text,
      "pan": panController.text,
      "pincode": pincodeController.text,
      "latitude": currentLocation.latitude.toString(),
      "longitude": currentLocation.longitude.toString(),
    };

    // Encode the data as JSON
    String requestBody = json.encode(requestData);

    // Define the API endpoint and headers
    final String apiEndpoint =
        "https://api.instantpay.in/cards/prepaid/initiateUserRegistration";
    final Map<String, String> headers = {
      "X-Ipay-Auth-Code": "1",
      "X-Ipay-Client-Id": "YWY3OTAzYzNlM2ExZTJlOfh549Gzt+5IEcETrD5Yx+Q=",
      "X-Ipay-Client-Secret":
          "679db35f926b8d0240a8c0d28729528ee8e6d5effa5fa0b20c04454004d2d825",
      "X-Ipay-Endpoint-Ip": "125.0.0.1",
      "X-Ipay-Request-Hash":
          "123456789|123456789|123456789|123456789|123456789|123456789|1234",
      "X-Ipay-Request-Timestamp": "1631081674077",
      "X-Ipay-Hash-Check": "OFF",
      "User-Agent": "InstantPayAPITest/1.0.0",
      "Content-Type": "application/json",
    };

    // Send the POST request
    final response = await http.post(Uri.parse(apiEndpoint),
        headers: headers, body: requestBody);

    // Handle the API response here (e.g., show a message to the user)
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Registration"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(labelText: "Mobile"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Mobile number is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: panController,
                decoration: InputDecoration(labelText: "PAN"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "PAN is required";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: pincodeController,
                decoration: InputDecoration(labelText: "Pincode"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Pincode is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submitForm();
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
