import 'package:flutter/material.dart';
import 'package:mon_premier_projet/models/Album.dart';
import 'package:mon_premier_projet/widgets/customDrawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_network/image_network.dart';

class MyAboutPage extends StatefulWidget {
  const MyAboutPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyAboutPage> createState() => _MyMyAboutPageState();
}

class _MyMyAboutPageState extends State<MyAboutPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),

      drawer: MyDrawer(currentPage: 'About'),
      body: Container(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Album?>(
                future: _getAlbum(),
                builder:
                    (BuildContext context, AsyncSnapshot<Album?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasData && snapshot.data != null) {
                        return Column(
                          children: [
                            Text(snapshot.data!.albumId.toString()),
                            Text(snapshot.data!.title),

                            SizedBox(height: 20),
                            // Add button route to the About page
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Go back'),
                            ),
                          ],
                        );
                      }
                      return Text('Error');
                    },
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<Album?> _getAlbum() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/photos/2');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      /*  var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>; */
      //var itemCount = jsonResponse['totalItems'];
      Album album = Album.fromJson(jsonDecode(response.body));

      return album;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return null;
    }
  }
}
