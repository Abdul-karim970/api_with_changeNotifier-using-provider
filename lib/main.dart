import 'package:api/API/album_api_provider/abum_provider.dart';
import 'package:api/API/photos_api_provider/photo.dart';
import 'package:api/API/photos_api_provider/photos_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ChangeNotifierProvider(
          create: (context) => AlbumApiChangeNotifier(),
          child: const MyHomePage(title: 'Photos API')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AlbumApiChangeNotifier albumApiChangeNotifier =
        context.read<AlbumApiChangeNotifier>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.blueGrey.shade100),
        ),
      ),
      body: Center(child: Consumer<AlbumApiChangeNotifier>(
        builder: (context, value, child) {
          if (albumApiChangeNotifier.isInitial) {
            return Text(
              'Empty',
              style: TextStyle(fontSize: 30),
            );
          } else if (albumApiChangeNotifier.isLoading) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: value.albums.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(value.albums[index].id.toString()),
                  title: Text(value.albums[index].title),
                );
              },
            );
          }
        },
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => albumApiChangeNotifier.fetchAlbums(),
        tooltip: 'Increment',
        backgroundColor: Colors.blueGrey,
        child: Icon(
          Icons.add,
          color: Colors.blueGrey.shade100,
        ),
      ),
    );
  }
}
