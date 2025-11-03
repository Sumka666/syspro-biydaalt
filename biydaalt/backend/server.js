// server.js эсвэл app.js дээр нэмнэ
import express from "express";
import pkg from "pg";
import dotenv from "dotenv";
import cors from "cors";
import bcrypt from "bcryptjs";

dotenv.config();
const { Pool } = pkg;
const app = express();

app.use(cors());
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
});

// ----------------- Register -----------------
app.post("/api/register", async (req, res) => {
  const { email, password, name } = req.body;

  if (!email || !password) {
    return res.status(400).json({ success: false, message: "Имэйл болон нууц үг шаардлагатай" });
  }

  try {
    // 1️⃣ Нууц үгийг bcrypt-ээр hash хийх
    const passwordHash = await bcrypt.hash(password, 10);

    // 2️⃣ PostgreSQL-д оруулах
    const result = await pool.query(
      "INSERT INTO users (email, password_hash, name) VALUES ($1, $2, $3) RETURNING id, email, name",
      [email, passwordHash, name]
    );

    res.json({
      success: true,
      message: "Амжилттай бүртгэгдлээ",
      user: result.rows[0],
    });
  } catch (error) {
    console.error(error);

    // Имэйл давхардсан тохиолдол
    if (error.code === "23505") {
      return res.status(400).json({ success: false, message: "Имэйл аль хэдийн бүртгэлтэй" });
    }

    res.status(500).json({ success: false, message: "Серверийн алдаа гарлаа" });
  }
});

// ----------------- Login -----------------
app.post("/api/login", async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ success: false, message: "Имэйл болон нууц үг шаардлагатай" });
  }

  try {
    const result = await pool.query("SELECT * FROM users WHERE email = $1", [email]);
    if (result.rows.length === 0) {
      return res.status(401).json({ success: false, message: "Имэйл эсвэл нууц үг буруу" });
    }

    const user = result.rows[0];
    const passwordMatch = await bcrypt.compare(password, user.password_hash);

    if (!passwordMatch) {
      return res.status(401).json({ success: false, message: "Имэйл эсвэл нууц үг буруу" });
    }

    res.json({ success: true, message: `Сайн байна уу, ${user.name || user.email}` });
  } catch (error) {
    console.error(error);
    res.status(500).json({ success: false, message: "Серверийн алдаа гарлаа" });
  }
});

// ----------------- Server start -----------------
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`✅ Server running on port ${PORT}`);
});
