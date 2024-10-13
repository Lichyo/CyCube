import 'package:flutter/material.dart';

class RegisterDialog extends StatefulWidget {
  final Function(String username, String email, String password, String role) onRegister;

  RegisterDialog({required this.onRegister});

  @override
  _RegisterDialogState createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _selectedRole = 'Student';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Register'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          Row(
            children: [
              DropdownButton<String>(
                value: _selectedRole,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedRole = newValue!;
                  });
                },
                items: <String>['Teacher', 'Student']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onRegister(
              _usernameController.text,
              _emailController.text,
              _passwordController.text,
              _selectedRole,
            );
            Navigator.pop(context);
          },
          child: const Text('Register'),
        ),
      ],
    );
  }
}
