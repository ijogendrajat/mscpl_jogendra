import 'package:flutter/material.dart';
import 'package:mscpl_jogendra/auth/otp_verify.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Your Mobile Number",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "We need to verity your number",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Mobile Number *',
                    hintText: 'Enter Mobile No.',
                    border: OutlineInputBorder(
                      // Use OutlineInputBorder for border styling
                      borderRadius: BorderRadius.circular(
                          10.0), // Define your desired border radius here
                      borderSide: BorderSide(
                        // Define border color and width
                        color: Colors
                            .blue, // Define your desired border color here
                        width: 2.0, // Define your desired border width here
                      ),
                    ),
                    // errorText: _errorText,
                  ),
                  onChanged: (value) {
                    setState(() {
                      //  _errorText = _validateMobile(value);
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 200,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.black), // Change the color here
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OtpScreen()),
                      );
                    },
                    child: const Text("Get OTP",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
              const Spacer(),
              const ListTile(
                leading: Icon(
                  Icons.circle,
                  color: Colors.blue,
                ),
                title: Text(
                  "Allow fydaa to send financial knowledge and critical alerts on your WhatsApp.",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
