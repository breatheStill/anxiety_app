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
app.get('/profile', getProfile);


// Route handlers
function home(req, res) {
  res.render('pages/index');
}

function getProfile(req, res) {
  res.render('pages/profile/show', {journals: journals});
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



// ======================================
// TEST DATA FOR RENDERING JOURNAL
// ======================================
const journals = [
  {
    id: 1,
    uid: 12,
    date: new Date(2018, 12, 31),
    exercise: false,
    outdoors: true,
    entry: 'Had a wonderful time with the family on the lake.',
    rating: 3
  },
  {
    id: 2,
    uid: 12,
    date: new Date(2019, 01, 01),
    exercise: true,
    outdoors: true,
    entry: 'Felt kind of hungover.',
    rating: 4
  },
  {
    id: 3,
    uid: 12,
    date: new Date(2019, 01, 09),
    exercise: false,
    outdoors: false,
    entry: 'Played computer games until my eyes bled.',
    rating: 9
  },
]