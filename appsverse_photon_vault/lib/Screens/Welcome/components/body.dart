import 'package:flutter/material.dart';
import 'package:appsverse_photon_vault/Screens/FoldersScreen/folders_page.dart';

import './background.dart';
import './rounded_button.dart';
import './rounded_input_field.dart';

class Body extends StatelessWidget {
  final String _password = "123456ABCDEF";
  final GlobalKey<FormState> _formKey;
  Body(this._formKey);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(
                "APPSVERSE",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
              ),
              Text(
                "Photo",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
              ),
              Text(
                "Vault",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
              ),
              SizedBox(height: size.height * 0.13),
              RoundedInputField(
                password: _password,
                hintText: "Your Password",
                onChanged: (value) {},
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FolderScreen()),
                    );
                  }
                },
              ),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}
