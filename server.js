'user strict';

// Load Dependencies
const express = require('express');
const cors = require('cors');
const superagent = require('superagent');
const pg = require('pg');
const methodOverride = require('method-override');

// Load env vars;
require('dotenv').config();
const PORT = process.env.PORT || 3000;

// PostgresQL setup
const client = new pg.Client(process.env.DATABASE_URL);
client.connect();
client.on('error', err => console.error(err));

// App setup, configure, and middlewares
const app = express();
app.use(cors());
app.use(express.urlencoded({extended: true}));
app.use(express.static('./public'));

app.use(methodOverride((req, res) => {
  if(req.body && typeof req.body === 'object' && '_method' in req.body){
    let method = req.body['_method'];
    delete req.body['_method'];
    return method;
  }
}));

app.set('view engine', 'ejs');


// Routes
app.get('/', home);


// Route handlers
function home(req, res) {
  res.render('pages/index');
}




// Error 404
app.get('/*', function(req, res) {
  res.status(404).render('pages/error', {
    message: 'This page does not exist',
    error: 'Not all those who wander are lost',
  })
});




// App listening on PORT
app.listen(PORT, () => {
  console.log(`server is up on port : ${PORT}`);
});
