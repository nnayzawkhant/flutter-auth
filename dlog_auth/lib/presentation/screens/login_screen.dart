import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dlog_auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:dlog_auth/presentation/bloc/auth/auth_event.dart';
import 'package:dlog_auth/presentation/bloc/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          // if (state is AuthAuthenticated) {
          //   Navigator.of(context).pushReplacementNamed('/home');
          // } else if (state is AuthError) {
          //   ScaffoldMessenger.of(context)
          //       .showSnackBar(SnackBar(content: Text(state.message)));
          // }
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final email = _emailController.text;
                  final password = _passwordController.text;
                  BlocProvider.of<AuthBloc>(context)
                      .add(LoginEvent(email, password));
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
