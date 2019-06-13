
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


final _formKey = GlobalKey<FormState>();



class UiTrial1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "This is it",
      home: Scaffold(
        appBar: AppBar(
          title: Text('This is app bar1'),
          actions: <Widget>[
            new Icon(Icons.search),
            new Icon(Icons.more_vert),
           
          ],
        ),
        
        body: Center(
          child: Otherwid(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
    
  }

  
}

class Otherwid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextFormField(
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter some text';
            }
          },
          autocorrect: true,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: RaisedButton(
            onPressed: () {
              // Validate will return true if the form is valid, or false if
              // the form is invalid.
              if (_formKey.currentState.validate()) {
                // Process data.
                
              }
            },
            child: Text('Submit'),
          ),
        ),
      ],
    ),
  );
  }
}


