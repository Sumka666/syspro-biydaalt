import express from "express";
import pkg from "pg";
import dotenv from "dotenv";
import bcrypt from "bcrypt";

dotenv.config();
const { Pool } = pkg;

const app = express();
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

app.use(express.json());

// ---------------- Register ----------------
app.post("/api/register", async (req, res) => {
  try {
    const { email, password, name } = req.body;
    if (!email || !password) {
      return res.status(400).json({ success: false, message: "Имэйл ба нууц үг шаардлагатай" });
    }

    // Хэрэглэгч байгаа эсэхийг шалгах
    const existingUser = await pool.query("SELECT * FROM users WHERE email=$1", [email]);
    if (existingUser.rows.length > 0) {
      return res.status(400).json({ success: false, message: "Имэйл аль хэдийн бүртгэгдсэн байна" });
    }

    // Нууц үгийг bcrypt ашиглан хэшлэх
    const saltRounds = 10;
    const password_hash = await bcrypt.hash(password, saltRounds);

    // Хэрэглэгчийг database-д нэмэх
    await pool.query(
      "INSERT INTO users (email, password_hash, name) VALUES ($1, $2, $3)",
      [email, password_hash, name || null]
    );

    res.status(201).json({ success: true, message: "Амжилттай бүртгэгдлээ" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Серверийн алдаа" });
  }
});

// ---------------- Login ----------------
app.post("/api/login", async (req, res) => {
  try {
    const { email, password } = req.body;
    if (!email || !password) {
      return res.status(400).json({ success: false, message: "Имэйл ба нууц үг шаардлагатай" });
    }

    const userQuery = await pool.query("SELECT * FROM users WHERE email=$1", [email]);
    if (userQuery.rows.length === 0) {
      return res.status(400).json({ success: false, message: "Имэйл олдсонгүй" });
    }

    const user = userQuery.rows[0];

    // Нууц үгийг шалгах
    const match = await bcrypt.compare(password, user.password_hash);
    if (!match) {
      return res.status(400).json({ success: false, message: "Нууц үг буруу" });
    }

    res.json({ success: true, message: `Амжилттай нэвтэрлээ, ${user.name || "Хэрэглэгч"}` });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Серверийн алдаа" });
  }
});

app.listen(process.env.PORT, () => {
  console.log(`✅ Server running on port ${process.env.PORT}`);
});
