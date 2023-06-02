var pg = require("pg");

const express = require("express");
const app = express();
const cors = require("cors");
app.use(cors());
app.use(express.json());

app.use(express.urlencoded());
app.use(express.static("public"));
const port = 5500;

//db connection
var conString =
  "postgres://sispycqu:aEU6aj5rj5ug2eKww7itHLxh3Cyx9plU@lucky.db.elephantsql.com/sispycqu"; //Can be found in the Details page

app.get("/", (req, res) => {
  res.sendFile(__dirname + "/index.html");
});

app.get("/data", (req, res) => {
  var client = new pg.Client(conString);
  client.connect(function (err) {
    if (err) {
      return console.error("could not connect to postgres", err);
    }
    client.query("SELECT * FROM tbl_student", function (err, result) {
      if (err) {
        return console.error("error running query", err);
      }
      res.send(result.rows);
      client.end();
    });
  });
});

app.post("/submit", (req, res) => {
  var client = new pg.Client(conString);

  client.connect(function (err) {
    if (err) {
      return console.error("could not connect to postgres", err);
    }
    client.query(
      `INSERT INTO tbl_student (Name, DOB,Address,Phone,Faculty) VALUES ('${req.body.name}', '${req.body.dob}','${req.body.address}','${req.body.phone}','${req.body.faculty}')`,
      function (err, result) {
        if (err) {
          return console.error("error running query", err);
        }
        res.redirect("/");
        client.end();
      }
    );
  });
});

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`);
});
