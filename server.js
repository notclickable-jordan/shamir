const express = require("express");
const app = express();
const PORT = 8080;

app.use(express.static("src"));

app.get("/", (req, res) => {
	res.send("Hello World!");
});

app.listen(PORT, () => console.log(`Server started at: http://localhost:${PORT}`));
