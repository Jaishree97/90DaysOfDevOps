require("dotenv").config();

const express = require("express");
const path = require("path");

const pool = require("./db");
const redisClient = require("./redis");

const app = express();
const PORT = process.env.PORT || 3000;

// Connect Redis
(async () => {
  await redisClient.connect();
  console.log("✅ Redis Connected");
})();

// Serve static files
app.use(express.static(path.join(__dirname, "public")));

// Home Page
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

// Health Check
app.get("/health", (req, res) => {
  res.json({
    status: "Running",
    service: "Product Catalog API"
  });
});

// Get Products
app.get("/products", async (req, res) => {
  try {
    // Increase page visits
    await redisClient.incr("page_visits");

    const visits = await redisClient.get("page_visits");

    const result = await pool.query(
      "SELECT * FROM products ORDER BY id"
    );

    res.json({
      database: "Connected",
      redis: "Connected",
      pageVisits: visits,
      products: result.rows
    });

  } catch (err) {
    console.error(err);
    res.status(500).json({
      error: err.message
    });
  }
});

// Start Server
app.listen(PORT, () => {
  console.log(`🚀 Server running on port ${PORT}`);
});
