import 'package:flutter/material.dart';
import 'package:latihanresponsi_124220025/pages/LoginPage.dart';
import 'package:latihanresponsi_124220025/util/Shared_Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // State variables
  String username = "";
  String password = "";
  String confirmPassword = "";
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text("Register Page"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset('images/images.jpeg'),
                  SizedBox(height: 20),
                  _usernameField(),
                  SizedBox(height: 16),
                  _passwordField(),
                  SizedBox(height: 16),
                  _confirmPasswordField(),
                  SizedBox(height: 16),
                  _registerButton(context),
                  const SizedBox(height: 20),
                  // Pesan untuk pengguna yang sudah memiliki akun
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: const Text(
                          "Login here",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
    );
  }

  Widget _usernameField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          username = value;
        });
      },
      decoration: InputDecoration(
        labelText: "Username",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: "Password",
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _confirmPasswordField() {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          confirmPassword = value;
        });
      },
      obscureText: !isConfirmPasswordVisible,
      decoration: InputDecoration(
        labelText: "Confirm Password",
        suffixIcon: IconButton(
          icon: Icon(isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isConfirmPasswordVisible = !isConfirmPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _registerButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (password == confirmPassword) {
          // Simpan akun ke SharedPreferences
          authServices.simpanAkun(username, password);
          // Navigasi ke halaman Login setelah registrasi berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          // Tampilkan pesan kesalahan jika password tidak cocok
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Passwords do not match')),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blueGrey,
      ),
      child: const Text("Register"),
    );
  }
}