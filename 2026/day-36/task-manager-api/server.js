const express = require("express");
const mongoose = require("mongoose");
const dotenv = require("dotenv");

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());

// MongoDB Connection
mongoose.connect(process.env.MONGO_URI)
.then(() => console.log("✅ MongoDB Connected"))
.catch(err => console.error("MongoDB Connection Error:", err));

// Home Route
app.get("/", (req, res) => {
    res.send(`
        <h1>🚀 Task Manager</h1>
        <p>Application is running successfully!</p>
        <hr>
        <h3>Available APIs</h3>
        <ul>
            <li>GET /tasks</li>
            <li>POST /tasks</li>
            <li>PUT /tasks/:id</li>
            <li>DELETE /tasks/:id</li>
        </ul>
    `);
});

// Task Routes
const taskRoutes = require("./routes/taskRoutes");
app.use("/tasks", taskRoutes);

// Start Server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
