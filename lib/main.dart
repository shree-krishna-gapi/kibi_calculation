import 'package:flutter/material.dart';
import 'package:kibi_calculation/firstTab.dart';
import 'package:kibi_calculation/pages/note_list.dart';
void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.brown[400],
    accentColor: Colors.brown[100],
    buttonColor: Colors.brown[400]
  ),
  home: HomePage(),
));

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController (
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text('KiBi Calculation'),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.border_all),text: ('Rectangle'),),
                  Tab(icon: Icon(Icons.all_out),text: ('Circular')),
                ],
              ),

              actions: <Widget>[
                new IconButton(icon: Icon(Icons.save), onPressed: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => NoteList()),
                  );
                }),

              ],

            ),
//            floatingActionButton: FloatingActionButton(
//              backgroundColor: Colors.brown[200],
//              child: Icon(Icons.add,color: Colors.white),
//             onPressed: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(builder: (context) => NoteList()),
//               );
//             }
//            ),
            body: TabBarView(
              children: [
                Container(
                  child:FirstTab(),

                ),
                Container(

                  color: Colors.green,
                  child: new IconButton(icon: Icon(Icons.search, color: Colors.white,),
//                      onPressed: (){
//                        Navigator.push(
//                          context,
//                          MaterialPageRoute(builder: (context) => SecondRoute()),
//                        );
//                      }),
                  ),
                ),
              ],
            ),
            drawer: new Drawer(
              child: new Column(
                  children: <Widget>[
                    new UserAccountsDrawerHeader(
                      accountName: Text('Shree Krishna',style: TextStyle(letterSpacing: 1)),
                      accountEmail: Text('Shreekrishnagapi@gmail.com',style: TextStyle(letterSpacing: 1)),
                      currentAccountPicture: GestureDetector(
                        child: new CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('assets/user.png'),

                        ),
                      ),
                      decoration: new BoxDecoration(
                        //                    color: Colors.yellow[800],
                          image: DecorationImage(image: AssetImage('assets/drawer.jpg'),fit: BoxFit.cover),

                          gradient: LinearGradient(colors:
                          [const Color(0xff66aaff),const Color(0xd9333333)],
                              stops: [0.0,0.9],
                              begin: FractionalOffset(0.1, 0.0),
                              end: FractionalOffset(0.0, 1.0)
                          )
                      ),
                    ),
                    InkWell(
                      child: ListTile(title: Text('Account',style: TextStyle(letterSpacing: 1)),leading: Icon(Icons.account_circle,color: Colors.blueGrey[400],size: 25.0,)),
                    ),
                    InkWell(
                      child: ListTile(title: Text('Saved',style: TextStyle(letterSpacing: 1)),leading: Icon(Icons.save,color: Colors.blueGrey[400],size: 25.0,)),
                    ),
                    InkWell(
                      child: ListTile(title: Text('Draft',style: TextStyle(letterSpacing: 1)),leading: Icon(Icons.drafts,color: Colors.blueGrey[400],size: 25.0,)),
                    ),
                    InkWell(
                      child: ListTile(title: Text('Setting',style: TextStyle(letterSpacing: 1)),leading: Icon(Icons.settings,color: Colors.blueGrey[400],size: 25.0)),
                    ),
                    Divider(),
                    InkWell(
                      child: ListTile(title: Text('Rate',style: TextStyle(letterSpacing: 1)),leading: Icon(Icons.favorite,color: Colors.red[200],size: 25.0)),
                    )


                  ]



              ),
            ),

          ),


    );
  }
}


