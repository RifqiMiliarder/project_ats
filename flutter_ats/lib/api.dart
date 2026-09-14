import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = "http://localhost:8000/api";

  static Future<List> getPosts() async {
    final response = await http.get(
      Uri.parse("$baseUrl/posts"),
    );

    print(response.body);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Gagal mengambil data");
    }
  }

  static Future<bool> tambahPost(
    String judul,
    String isi,
    int kategoriId,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/posts"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "judul": judul,
        "isi": isi,
        "kategori_id": kategoriId,
      }),
    );

    return response.statusCode == 201;
  }

  static Future<bool> editPost(
    int id,
    String judul,
    String isi,
    int kategoriId,
  ) async {
    final response = await http.put(
      Uri.parse("$baseUrl/posts/$id"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "judul": judul,
        "isi": isi,
        "kategori_id": kategoriId,
      }),
    );

    return response.statusCode == 200;
  }

  static Future<bool> hapusPost(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/posts/$id"),
    );

    return response.statusCode == 200;
  }
}