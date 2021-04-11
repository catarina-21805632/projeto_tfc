import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:share/share.dart';

import 'login.dart';

bool isReg = false;

class DetailsScreen extends StatefulWidget {

  final event;

  DetailsScreen(this.event);

  @override
  State<StatefulWidget> createState(){
    return _DetailsScreenState(event);
  }

}

class _DetailsScreenState extends State<DetailsScreen>{

  final String event;

  _DetailsScreenState(this.event);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          titulo(event),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.share, color: Colors.white),
              onPressed: (){
                Share.share("Vou à prova ${titulo(event)} com a minha empresa :)");
              }
          )
        ],
      ),
      body: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Container(
                  child: Column(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(15.0),
                          height: 55.0,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color().plafond)
                          ),
                          child: Text(
                            'Plafond: $plafond€',
                            style: TextStyle(fontSize: 20.0, color: Colors.orange, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: Image(image: AssetImage(imagem(event)), width: 200,
                            height: 150,),
                        ),
                        SizedBox(height: 50),
                        Text(
                            'Date: ' + data(event)
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Deadline: ' + prazo(event)
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Local: ' + local(event)
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Type: ' + tipo(event)
                        ),
                        SizedBox(height: 20),
                        Text(
                            'Cost: ' + custo(event) + '€'
                        ),
                        SizedBox(height: 50),
                        ButtonTheme(
                          minWidth: 380.0,
                          height: 55.0,
                          child: isInscrito(),
                        ),
                      ]
                  ),
                ),
              ),
            );
          }
      ),
    );
  }

  void showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
      child: Text("Register"),
      color: Colors.green,
      onPressed:  () {
        if(plafond >= int.parse(custo(event))){
          setState(() {
            isReg = true;
            plafond -= int.parse(custo(event));
          });
          Navigator.pop(context);
        }else{
          showAlertDialog3(context);
        }
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(titulo(event)),
      content: Text("Are you sure you want to register for this event?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void showAlertDialog2(BuildContext context) {

    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = RaisedButton(
      child: Text("Yes, Cancel"),
      color: Colors.red,
      onPressed:  () {
        setState(() {
          plafond += int.parse(custo(event));
          isReg = false;
        });
        Navigator.pop(context);
      },
    );


    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(titulo(event)),
      content: Text("Are you sure you want to cancel you registration for this event?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog3(BuildContext context) {

    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(titulo(event)),
      content: Text("Your plafond is not enough to register for this event."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget isInscrito(){
    if(isReg){
      return RaisedButton(
        color: Color().primaryColor,
        child: Text(
          'Cancel',
          style: TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
        ),
        onPressed: () {
          showAlertDialog2(context);
        },
      );
    }
    return RaisedButton(
      color: Color().primaryColor,
      child: Text(
        'Register',
        style: TextStyle(
            color: Colors.white,
            fontSize: 20
        ),
      ),
      onPressed: () {
        showAlertDialog(context);
      },
    );
  }

  String titulo(String event){
    var arr = event.split(",");
    var arr2 = arr[0].split(": ");

    return arr2[1];
  }

  String data(String event){
    var arr = event.split(",");
    var arr2 = arr[1].split(": ");

    return arr2[1];
  }

  String prazo(String event){
    var arr = event.split(",");
    var arr2 = arr[2].split(": ");

    return arr2[1];
  }

  String local(String event){
    var arr = event.split(",");
    var arr2 = arr[3].split(": ");

    return arr2[1];
  }

  String tipo(String event){
    var arr = event.split(",");
    var arr2 = arr[4].split(": ");

    return arr2[1];
  }

  String custo(String event){
    var arr = event.split(",");
    var arr2 = arr[5].split(": ");

    return arr2[1];
  }

  String imagem(String event){
    var arr = event.split(",");
    var arr2 = arr[6].split(": ");

    return arr2[1].replaceAll('}', '');
  }

}