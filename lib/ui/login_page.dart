import 'package:flutter/material.dart';
import '../bloc/login_bloc.dart';
import '../helpers/user_info.dart';
import '../widget/warning_dialog.dart';
import '/ui/registrasi_page.dart';
import 'transportasi_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final _emailTextboxController = TextEditingController();
  final _passwordTextboxController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.yellow, 
      ),
      backgroundColor:
          Colors.yellow[100], 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(120.0), 
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _emailTextField(),
                const SizedBox(height: 12), 
                _passwordTextField(),
                const SizedBox(height: 20),
                _buttonLogin(),
                const SizedBox(height: 30),
                _menuRegistrasi(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Membuat Textbox email
  Widget _emailTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Email",
        border: OutlineInputBorder(), 
        filled: true,
        fillColor: Colors.white, 
      ),
      keyboardType: TextInputType.emailAddress,
      controller: _emailTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email harus diisi';
        }
        return null;
      },
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: "Password",
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: _passwordTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Password harus diisi";
        }
        return null;
      },
    );
  }

  Widget _buttonLogin() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, 
        backgroundColor: Colors.yellow, 
        padding: const EdgeInsets.symmetric(
            vertical: 15, horizontal: 30), 
      ),
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 18), 
      ),
      onPressed: () {
        var validate = _formKey.currentState!.validate();
        if (validate) {
          if (!_isLoading) _submit();
        }
      },
    );
  }

  void _submit() {
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    LoginBloc.login(
      email: _emailTextboxController.text,
      password: _passwordTextboxController.text,
    ).then((value) async {
      if (value.code == 200) {
        print(value.userID);
        await UserInfo().setToken(value.token!);
        await UserInfo().setUserID(value.userID!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const TransportasiPage()),
        );
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => const WarningDialog(
            description: "Login gagal, silahkan coba lagi",
          ),
        );
      }
    }, onError: (error) {
      print(error);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const WarningDialog(
          description: "Login gagal, silahkan coba lagi",
        ),
      );
    });
    setState(() {
      _isLoading = false;
    });
  }

  Widget _menuRegistrasi() {
    return Center(
      child: InkWell(
        child: const Text(
          "Registrasi",
          style: TextStyle(
            color: Color.fromARGB(255, 255, 230, 0),
            fontSize: 16,
            fontWeight: FontWeight.bold, 
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RegistrasiPage()),
          );
        },
      ),
    );
  }
}
