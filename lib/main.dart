import 'package:firstapp/menu_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


import 'alarm_page.dart';
import 'clock_view.dart';
import 'constants/theme_data.dart';
import 'enums.dart';
import 'package:firstapp/data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:ChangeNotifierProvider<MenuInfo>(
        create: (context) => MenuInfo(MenuType.clock, imageSource: '', title: ''), 
        child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    var now=DateTime.now();
    var formattedTime = DateFormat('HH:mm').format(now);
    var formattedDate = DateFormat('EEE,d MMM').format(now);
    var timezoneString=now.timeZoneOffset.toString().split('.').first;
    var offsetSign=' ';
    if(!timezoneString.startsWith('-'))
      offsetSign='+';
    print(timezoneString);
    return Scaffold(
      backgroundColor: Color(0xFF2D2F41),
      body: Row(
        children:<Widget> [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: 
          menuItems.map((currentMenuInfo) => buildMenuButton(currentMenuInfo))
          .toList(),
          ),
          VerticalDivider(color: Colors.white54,
          width:1,
          ),
          Expanded(
              child: Consumer<MenuInfo>(

                builder: (BuildContext context,MenuInfo value,Widget child) {
                     if(value.menuType!=MenuType.clock) return AlarmPage();
                     
                      return Container(
                padding: EdgeInsets.symmetric(horizontal:32, vertical:64),
                color: Color(0xFF2D2F41),
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: <Widget>[
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(
                        'Clock',
                        style:TextStyle(fontFamily:'avenir',fontWeight:FontWeight.w700 , color: Colors.white,fontSize: 24),
                        ),
                      ),
                      Flexible(
                          flex:2,
                          child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             formattedTime,
                            style:TextStyle(fontFamily:'avenir', color: Colors.white,fontSize: 64),
                            ),
                             Text(
                         formattedDate,
                        style:TextStyle(fontFamily:'avenir',fontWeight:FontWeight.w300, color: Colors.white,fontSize: 20),
                        ),
                          ],
                           
                        ),
                      ),
                        
                    Flexible(
                        
                        flex: 4,
                        fit: FlexFit.tight,
                        child:Align(alignment: Alignment.center, child:ClockView(size: MediaQuery.of(context).size.height/4,
                        // Column is also a layout widget. It takes a list of children and
                        // arranges them vertically. By default, it sizes itself to fit its
                        // children horizontally, and tries to be as tall as its parent.
                        //
                        // Invoke "debug painting" (press "p" in the console, choose the
                        // "Toggle Debug Paint" action from the Flutter Inspector in Android
                        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
                        // to see the wireframe for each widget.
                        //
                        // Column has various properties to control how it sizes itself and
                        // how it positions its children. Here we use mainAxisAlignment to
                        // center the children vertically; the main axis here is the vertical
                        // axis because Columns are vertical (the cross axis would be
                        // horizontal).
                      ),
                        ),
                    ),
                    Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Timezone',
                            style:TextStyle(fontFamily:'avenir',fontWeight:FontWeight.w500 ,color: Colors.white,fontSize: 24),
                            ),
                             SizedBox(height:16),
                        Row(
                          children:<Widget>[
                            Icon(
                              Icons.language,
                             color:Colors.white
                             ),
                              SizedBox(width:16),
                              Text(
                              'UTC'+offsetSign+timezoneString,
                              style:TextStyle(fontFamily:'avenir', color: Colors.white,fontSize: 14),
                               ),

                          ]
                        ),
                        ],
                      ),
                    ),
                      
                  ],
                )
            );
          },
                
              
              ),
          ),
        ],
      )
    );
  }

  Widget buildMenuButton(MenuInfo currentMenuInfo) {
    return Consumer<MenuInfo>(
          builder: (BuildContext context, MenuInfo value,Widget child) {
              return FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius:BorderRadius.only(topRight: Radius.circular(32)) ),
                     padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0),
                     color:currentMenuInfo.menuType ==value.menuType ? CustomColors.menuBackgroundColor:Colors.transparent,
                     onPressed: () {
                         var menuInfo = Provider.of<MenuInfo>(context,listen: false);
                         menuInfo.upadateMenu(currentMenuInfo);
                     }, child: Column(
                     children:<Widget>[
                       Image.asset(currentMenuInfo.imageSource,scale: 1.5,),
                       SizedBox(height:16),
                       Text(
                        currentMenuInfo.title, 
                        style: TextStyle(
                         fontFamily:'avenir', color: Colors.white, fontSize:14)
                       )
                     ]
               )
               );
          },
    );
  }
}
