import 'package:flutter/material.dart';


class FirstTab extends StatefulWidget {
  @override
  _FirstTabState createState() => _FirstTabState();
}

class _FirstTabState extends State<FirstTab> {
  var _formKey = GlobalKey<FormState>();
  var _current_Value = ['inc', 'ft', 'meter'];
  var _current_Selected_Length = 'ft';
  var _current_Selected_Breath = 'inc';
  var _current_Selected_Height = 'inc';
  final _minimumPadding = 10.0;
  var display_result = '';

  TextEditingController lControlled = TextEditingController();
  TextEditingController bControlled = TextEditingController();
  TextEditingController hControlled = TextEditingController();
  TextEditingController pControlled = TextEditingController();

  @override
  Widget build(BuildContext context) {


    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding),
              child: Text(display_result,style: TextStyle(color: Colors.brown[700]),textScaleFactor: 1.2),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                        ),
                        controller: lControlled,
                        validator: (String value){
                          if(value.isEmpty) {
                            return '* Insert the length';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: 'length',
                            hintText: 'length of wood',
                            labelStyle: TextStyle(
                              fontSize: 15.0,
                            )
                        )
                    ),),
                  Container(width: _minimumPadding * 5,),
                  Expanded(

                      flex: 3,
                      child: DropdownButton<String>(
                        items: _current_Value.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black87,
                            ),),
                          );
                        }).toList(),
                        value: _current_Selected_Length,
                        onChanged: (String newLengthSelected) {
                          _onDropDownLengthSelected(newLengthSelected);
                        },
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 4,child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                      ),
                      controller: bControlled,
                      validator: (String value){
                        if(value.isEmpty) {
                          return '* Insert the Breath';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Breath',
                          hintText: 'Breath of wood',
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          )
                      )
                  ),),
                  Container(width: _minimumPadding * 5,),
                  Expanded(flex: 3,child: DropdownButton<String>(
                    items: _current_Value.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _current_Selected_Breath,
                    onChanged: (String newBreathSelected) {
                      _onDropDownBreathSelected(newBreathSelected);
                    },
                  )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(flex: 4,child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black87,
                      ),
                      controller: hControlled,
                      validator: (String value){
                        if(value.isEmpty) {
                          return '* Insert the Height';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Height',
                          hintText: 'Height of wood',
                          labelStyle: TextStyle(
                            fontSize: 15.0,
                          )
                      )
                  ),),
                  Container(width: _minimumPadding * 5,),
                  Expanded(flex: 3,child: DropdownButton<String>(
                    items: _current_Value.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: _current_Selected_Height,
                    onChanged: (String newHeightSelected) {
                      _onDropDownHeightSelected(newHeightSelected);
                    },
                  )),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: _minimumPadding),
              child: TextField(
                  keyboardType: TextInputType.number,


                  controller: pControlled,
                  decoration: InputDecoration(
                    labelText: 'Price / per kibi',
                    hintText: 'Price per KiBi of wood',

                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minimumPadding * 5),
              child: RaisedButton(
                color:Colors.brown,
                child: Text('Convert', textScaleFactor: 1.2,style: TextStyle(color:Colors.white),),
                onPressed: () {
                  setState(() {
                    if(_formKey.currentState.validate()){
                      this.display_result = _calculateTotalReturns();
                    }
                  });
                },
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: _minimumPadding / 2),
                child: RaisedButton(
//                  color: Theme.of(context).primaryColorDark,
                  color: Colors.brown[400],
                  child: Text('Reset', textScaleFactor: 1.2, style:TextStyle(color:Colors.white),),
                  onPressed: () {
                    _reset();
                  },
                )
            ),


          ],
        ),
      ),

    );
  }

  void _onDropDownLengthSelected(newLengthSelected) {
    setState(() {
      this._current_Selected_Length = newLengthSelected;
    });
  }

  void _onDropDownBreathSelected(newBreathSelected) {
    setState(() {
      this._current_Selected_Breath = newBreathSelected;
    });
  }

  void _onDropDownHeightSelected(newHeightSelected) {
    setState(() {
      this._current_Selected_Height = newHeightSelected;
    });
  }

  String _calculateTotalReturns() {
//    int i = 12;
//    int f = 144;
//    int m = 39;
    double kb;
    double price = 0;
    double tot;
    var fst_string = 'Total kibi wood is: ';
    var snd_string = 'Total price of wood is: ';
    double l = double.parse(lControlled.text);
    double b = double.parse(bControlled.text);
    double h = double.parse(hControlled.text);
    double p = double.parse(pControlled.text);
    if ((_current_Selected_Length == 'ft' && _current_Selected_Breath == 'inc' && _current_Selected_Height == 'inc') ||
        (_current_Selected_Length == 'inc' && _current_Selected_Breath == 'ft' && _current_Selected_Height == 'inc') ||
        (_current_Selected_Length == 'inc' && _current_Selected_Breath == 'inc' && _current_Selected_Height == 'ft')) {
      kb = l*b*h;
      tot = kb/144;
      price = tot*p;
      String result = '$fst_string $tot \n$snd_string $price';
      return result;
    }
    else if (_current_Selected_Length == 'ft' && _current_Selected_Breath == 'ft' &&
        _current_Selected_Height == 'ft') {
      tot = l*b*h;
      price = tot*p;
      String result = '$fst_string $tot \t $snd_string $price';
      return result;
    }
    else if (
    (_current_Selected_Length == 'inc' && _current_Selected_Breath == 'ft' && _current_Selected_Height == 'ft') ||
        (_current_Selected_Length == 'ft' && _current_Selected_Breath == 'inc' && _current_Selected_Height == 'ft') ||
        (_current_Selected_Length == 'ft' && _current_Selected_Breath == 'ft' && _current_Selected_Height == 'inc')) {
      if(_current_Selected_Length=='inc') {
        kb = l/12;
        tot = kb*b*h;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if(_current_Selected_Breath=='inc') {
        kb = b/12;
        tot = kb*l*h;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if(_current_Selected_Height=='inc') {
        kb = h/12;
        tot = kb*b*l;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
    }
    else if (_current_Selected_Length == 'inc' && _current_Selected_Breath == 'inc' &&
        _current_Selected_Height == 'inc') {
      kb = l/12/144;
      tot = kb*b*h;
      price = tot*p;
      String result = '$fst_string $tot \t $snd_string $price';
      return result;
    }
    else if (_current_Selected_Length == 'meter' && _current_Selected_Breath == 'meter' &&
        _current_Selected_Height == 'meter') {
      tot = l*3.280839895*b*3.280839895*h*3.280839895;
      price = tot*p;
      String result = '$fst_string $tot \t $snd_string $price';
      return result;
    }
    else if (
    (_current_Selected_Length=='meter' && _current_Selected_Breath=='ft' && _current_Selected_Height=='ft')||
        (_current_Selected_Length=='ft' && _current_Selected_Breath=='meter' && _current_Selected_Height=='ft') ||
        (_current_Selected_Length=='ft' && _current_Selected_Breath=='ft' && _current_Selected_Height=='meter') ) {
      if (_current_Selected_Length=='meter') {
        kb = l*3.28084;
        tot = kb*h*b;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if (_current_Selected_Breath=='meter') {
        kb = b*3.28084;
        tot = kb*h*l;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if (_current_Selected_Height=='meter') {
        kb = h*3.28084;
        tot = kb*b*l;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
    }
    else if (
    (_current_Selected_Length=='meter' && _current_Selected_Breath=='meter' && _current_Selected_Height=='ft')||
        (_current_Selected_Length=='ft' && _current_Selected_Breath=='meter' && _current_Selected_Height=='meter') ||
        (_current_Selected_Length=='meter' && _current_Selected_Breath=='ft' && _current_Selected_Height=='meter') ) {
      if (_current_Selected_Length=='ft') {
        tot = l*h*3.28084*b*3.28084;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if (_current_Selected_Breath=='ft') {
        tot = b*h*3.28084*l*3.28084;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if (_current_Selected_Height=='ft') {
        tot = h*l*3.28084*b*3.28084;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
    }
    else if (
    (_current_Selected_Length=='meter' && _current_Selected_Breath=='meter' && _current_Selected_Height=='inc')||
        (_current_Selected_Length=='inc' && _current_Selected_Breath=='meter' && _current_Selected_Height=='meter') ||
        (_current_Selected_Length=='meter' && _current_Selected_Breath=='inc' && _current_Selected_Height=='meter') ) {
      if (_current_Selected_Length=='inc') {
        kb = l/12;
        tot = kb*b*3.28084*h*3.28084;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if (_current_Selected_Breath=='inc') {
        kb = b/12;
        tot = kb*l*3.28084*h*3.28084;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if (_current_Selected_Height=='inc') {
        kb = h/12;
        tot = kb*b*3.28084*l*3.28084;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
    }
    else if (
    (_current_Selected_Length=='meter' && _current_Selected_Breath=='inc' && _current_Selected_Height=='inc')||
        (_current_Selected_Length=='inc' && _current_Selected_Breath=='meter' && _current_Selected_Height=='inc') ||
        (_current_Selected_Length=='inc' && _current_Selected_Breath=='inc' && _current_Selected_Height=='meter') ) {
      if (_current_Selected_Length=='meter') {
        kb = l*3.28084/144;
        tot = kb*b*h;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if (_current_Selected_Breath=='meter') {
        kb = b*3.28084/144;
        tot = kb*l*h;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if (_current_Selected_Height=='meter') {
        kb = h*3.28084/144;
        tot = kb*b*l;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
    }
    else if (
    (_current_Selected_Length=='meter' && _current_Selected_Breath=='inc' && _current_Selected_Height=='ft')||
        (_current_Selected_Length=='ft' && _current_Selected_Breath=='meter' && _current_Selected_Height=='inc')||
        (_current_Selected_Length=='inc' && _current_Selected_Breath=='ft' && _current_Selected_Height=='meter')||
        (_current_Selected_Length=='ft' && _current_Selected_Breath=='inc' && _current_Selected_Height=='meter')||
        (_current_Selected_Length=='inc' && _current_Selected_Breath=='meter' && _current_Selected_Height=='ft')){
      if ((_current_Selected_Length=='meter') && (_current_Selected_Breath=='inc')){
        kb = l*3.28084;
        tot = b/12*kb*h;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if ((_current_Selected_Length=='inc') && (_current_Selected_Breath=='meter')) {
        kb = b*3.28084;
        tot = l/12*kb*h;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
      else if ((_current_Selected_Height=='meter') && (_current_Selected_Breath=='inc')) {
        kb = h*3.28084;
        tot = b/12*kb*l;
        price = tot*p;
        String result = '$fst_string $tot \t $snd_string $price';
        return result;
      }
    }
    else {
      String result = 'Opps! Somthing is Wrong.';
      return result;
    }
  }

  void _reset() {
    lControlled.text = '';
    bControlled.text = '';
    hControlled.text = '';
    pControlled.text = '';
    display_result = '';
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('assets/wood.png');
    Image image = Image(image: assetImage, height: 180.0,);
    return Container(child:image, margin: EdgeInsets.all(1.0));
  }
}
