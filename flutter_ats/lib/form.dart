import 'package:flutter/material.dart';
import 'api.dart';

class FormPage extends StatefulWidget {
  final Map? post;

  const FormPage({
    super.key,
    this.post,
  });

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final judulController = TextEditingController();
  final isiController = TextEditingController();

  int kategoriId = 1;

  bool get editMode => widget.post != null;

  @override
  void initState() {
    super.initState();

    if (editMode) {
      judulController.text = widget.post!["judul"];
      isiController.text = widget.post!["isi"];
      kategoriId = widget.post!["kategori_id"];
    }
  }

  void simpan() async {
    if (judulController.text.isEmpty ||
        isiController.text.isEmpty) {
      return;
    }

    bool berhasil;

    if (editMode) {
      berhasil = await Api.editPost(
        widget.post!["id"],
        judulController.text,
        isiController.text,
        kategoriId,
      );
    } else {
      berhasil = await Api.tambahPost(
        judulController.text,
        isiController.text,
        kategoriId,
      );
    }

    if (berhasil) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          editMode ? "Edit Artikel" : "Tambah Artikel",
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            TextField(
              controller: judulController,
              decoration: const InputDecoration(
                labelText: "Judul",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<int>(
              value: kategoriId,

              decoration: const InputDecoration(
                labelText: "Kategori",
                border: OutlineInputBorder(),
              ),

              items: const [
                DropdownMenuItem(
                  value: 1,
                  child: Text("Sport"),
                ),

                DropdownMenuItem(
                  value: 2,
                  child: Text("Kriminal"),
                ),

                DropdownMenuItem(
                  value: 3,
                  child: Text("Bencana"),
                ),
              ],

              onChanged: (value) {
                setState(() {
                  kategoriId = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            TextField(
              controller: isiController,
              maxLines: 6,

              decoration: const InputDecoration(
                labelText: "Isi Artikel",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: simpan,
                child: Text(
                  editMode ? "Edit" : "Simpan",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}