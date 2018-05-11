const express = require('express');
const mysql = require('mysql2');
const app = express();
const PORT = process.env.PORT || 80;

const pool = mysql.createPool({
  connectionLimit: 10,
  host: 'db',
  user: 'root',
  password: 'root',
  database: 'testdb',
  insecureAuth: true
});

app.get('/', function(req, res) {
  res.send('Hello World');
});

app.get('/db', function(req, res, next) {
  pool.query('SELECT * FROM migrations', function(err, rows, fields) {
    if (err) {
      return next(err);
    }
    res.send('Number of rows:' + rows.length);
  });
});

app.listen(PORT, () => {
  console.log('Server up...');
});
