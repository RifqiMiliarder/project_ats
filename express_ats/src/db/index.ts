import mysql from "mysql2";

const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "najwaputri24",
  database: "db_blog_app"
});

db.connect((err) => {
  if (err) {
    console.log("Database gagal terhubung");
    console.log(err.message);
  } else {
    console.log("Database berhasil terhubung");
  }
});

export default db;