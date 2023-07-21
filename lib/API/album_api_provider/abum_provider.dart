import 'package:api/API/API_provider.dart';
import 'package:api/API/album_api_provider/album.dart';
import 'package:flutter/material.dart';

class AlbumApiProvider extends APIProvider {
  @override
  String get apiUrl => 'albums';

  Future<List<Album>> fetchAlbums() async {
    List mapList = await fetch();
    return mapList.map((map) => Album.fromMap(map)).toList();
  }

  Future<Album> fetchAlbum({required String endPoint}) async {
    var map = await fetch(endPoint: endPoint);
    return Album.fromMap(map);
  }
}

class AlbumApiChangeNotifier extends ChangeNotifier {
  bool isInitial = true;
  bool isLoading = false;
  bool isLoaded = false;
  List<Album> albums = List.empty();
  Future<List<Album>> fetchAlbums() async {
    AlbumApiProvider albumApiProvider = AlbumApiProvider();
    isInitial = false;
    isLoading = true;
    notifyListeners();
    albums = await albumApiProvider.fetchAlbums();
    isLoading = false;
    isLoaded = true;
    notifyListeners();
    return albums;
  }
}
