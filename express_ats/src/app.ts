import express from "express";
import cors from "cors";
import db from "./db";

const app = express();

app.use(cors());
app.use(express.json());


app.get("/api/posts", (req, res) => {
  db.query(
    `SELECT 
      posts.id,
      posts.judul,
      posts.isi,
      posts.kategori_id,
      categories.nama AS kategori
    FROM posts
    JOIN categories ON posts.kategori_id = categories.id`,
    (err, result) => {
      if (err) {
        return res.status(500).json({
          message: "Gagal mengambil data"
        });
      }

      res.status(200).json(result);
    }
  );
});


app.post("/api/posts", (req, res) => {
  const { judul, isi, kategori_id } = req.body;

  if (!judul || !isi || !kategori_id) {
    return res.status(400).json({
      message: "Data belum lengkap"
    });
  }

  db.query(
    "INSERT INTO posts (judul, isi, kategori_id) VALUES (?, ?, ?)",
    [judul, isi, kategori_id],
    (err, result) => {
      if (err) {
        return res.status(500).json({
          message: "Gagal menambah artikel"
        });
      }

      res.status(201).json({
        message: "Artikel berhasil ditambahkan"
      });
    }
  );
});


app.put("/api/posts/:id", (req, res) => {
  const id = req.params.id;
  const { judul, isi, kategori_id } = req.body;

  if (!judul || !isi || !kategori_id) {
    return res.status(400).json({
      message: "Data belum lengkap"
    });
  }

  db.query(
    "UPDATE posts SET judul = ?, isi = ?, kategori_id = ? WHERE id = ?",
    [judul, isi, kategori_id, id],
    (err, result) => {
      if (err) {
        return res.status(500).json({
          message: "Gagal mengedit artikel"
        });
      }

      res.status(200).json({
        message: "Artikel berhasil diedit"
      });
    }
  );
});


app.delete("/api/posts/:id", (req, res) => {
  const id = req.params.id;

  db.query(
    "DELETE FROM posts WHERE id = ?",
    [id],
    (err, result) => {
      if (err) {
        return res.status(500).json({
          message: "Gagal menghapus artikel"
        });
      }

      res.status(200).json({
        message: "Artikel berhasil dihapus"
      });
    }
  );
});


app.listen(8000, () => {
  console.log("Server berjalan di port 8000");
});