import 'package:flutter/material.dart';
import '/helpers/user_info.dart';
import '/ui/login_page.dart';
import '/ui/transportasi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  // Cek apakah pengguna sudah login atau belum
  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page =
            const TransportasiPage(); // Halaman transportasi jika sudah login
      });
    } else {
      setState(() {
        page = const LoginPage(); // Halaman login jika belum login
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transportasi', // Nama aplikasi
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light, // Tema terang
        primaryColor: Colors.yellow, // Warna utama kuning
        scaffoldBackgroundColor: Colors.white, // Latar belakang putih
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow, // AppBar dengan warna kuning
          titleTextStyle: TextStyle(
            fontFamily: 'Helvetica', // Menggunakan font Helvetica
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black, // Warna teks AppBar
          ),
          iconTheme: IconThemeData(color: Colors.black), // Warna ikon
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'Helvetica', // Font body teks 1
            fontSize: 16,
            color: Colors.black,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Helvetica', // Font body teks 2
            fontSize: 14,
            color: Colors.black,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Helvetica',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.yellow, // Warna tombol kuning
          textTheme: ButtonTextTheme.primary,
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.black,
            side: const BorderSide(color: Colors.yellow), // Border kuning
            textStyle: const TextStyle(
              fontFamily: 'Helvetica', // Font pada tombol
              fontSize: 16,
            ),
          ),
        ),
      ),
      home: page,
    );
  }
}
