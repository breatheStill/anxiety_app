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


// ============================
// Routes
// ============================

app.get('/', home);
app.get('/login', renderLogin);
app.post('/login', verifyLogin);
app.post('/create', createUser);
app.get('/profile/:uid', getProfile);
app.post('/new', newJournal);
app.post('/login', createAndLogin)


// ============================
// Route handlers
// ============================

function home(req, res) {
  res.render('pages/index');
}

function renderLogin(req, res) {
  res.render('pages/login/show');
}

function verifyLogin(req, res) {
  const SQL = 'SELECT * FROM users WHERE username=$1;';
  const values = [req.body.username];

  client.query(SQL, values)
    .then(result => {
      if (result.rows.length === 0) {
        res.render('pages/login/show', {errorMessage: 'Username does not exist'});
      } else {
        const uid = result.rows[0].id;
        const pw = result.rows[0].password;
        if (req.body.password === pw) {
          res.redirect(`/profile/${uid}`);
        } else {
          res.render('pages/login/show', {errorMessage: 'Password incorrect'});
        }
      }
    })
    .catch(err => handleError(err, res));
}

function createUser(req, res) {
  res.render('pages/login/new');
}

function getProfile(req, res) {
  const SQL = 'SELECT * FROM journals WHERE uid=$1;';
  const values = [req.params.uid];

  client.query(SQL, values)
    .then(result => {
      res.render('pages/profile/show', {
        journals: result.rows,
        uid: req.params.uid,
        username: req.param.username
      });
    })
    .catch(err => handleError(err, res));
}

function newJournal(req, res) {
  // placeholder helper function until Mood API connected
  const rating = getRating(req.body.entry);

  const SQL = `INSERT INTO journals(uid, date, exercise, outdoors, entry, rating) VALUES($1, $2, $3, $4, $5, $6);`;

  const values = [req.body.uid, req.body.date, req.body.exercise !== undefined, req.body.outdoors !== undefined, req.body.entry, rating];

  client.query(SQL, values)
    .then(result => {
      res.redirect(`/profile/${req.body.uid}`);
    })
    .catch(err => handleError(err, res));
}

function createAndLogin (req, res) {
  let SQL = 'SELECT * FROM user WHERE username=$1;';
  let values = [req.body.username];

  client.query(SQL, values)
    .then(result => {
      if (req.body.username === result.rows[0].username) {
        res.render('pages/login/show', {errorMessage: 'Username already exists'});
      }
    })
    .catch(err => console.error(err));

    let SQL = 'INSERT INTO users (username, password) VALUES ($1, $2) RETURNING id';

    return client.query(SQL, [req.body.username, req.body.password])
      .then(result => {
        res.redirect(`/profile/${result.rows[0].id}`);
      })
      .catch(err => handleError(err,res));
}


// ============================
// Helper functions
// ============================
function getRating(entry) {
  // TODO: retrieve from Mood API
  //  For now return random int 1 - 10
  return Math.floor(Math.random() * 11);
}



// Error 404
app.get('/*', function(req, res) {
  res.status(404).render('pages/error', {
    message: 'This page does not exist',
    error: 'Not all those who wander are lost',
  })
});


// Server error handler
function handleError(err, res) {
  console.error(err);
  if (res) res.status(500).render('pages/error', {
    message: 'Server Error',
    error: err
  });
}




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
    uid: 1,
    date: new Date(2018, 12, 31),
    exercise: false,
    outdoors: true,
    entry: 'Consectetur dolorum aliquam, totam vero odit sit quasi consequatur aspernatur corporis tempora rerum autem. Aliquid itaque enim quibusdam repellat consectetur totam consequuntur. Had a wonderful time with the family on the lake.',
    rating: 3
  },
  {
    id: 2,
    uid: 1,
    date: new Date(2019, 01, 01),
    exercise: true,
    outdoors: true,
    entry: 'Felt kind of hungover. Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur dolorum aliquam, totam vero odit sit quasi consequatur aspernatur corporis tempora rerum autem. Aliquid itaque enim quibusdam repellat consectetur totam consequuntur.',
    rating: 4
  },
  {
    id: 3,
    uid: 1,
    date: new Date(2019, 01, 09),
    exercise: false,
    outdoors: false,
    entry: 'Played computer games until my eyes bled. Lorem ipsum dolor sit amet consectetur adipisicing elit. ',
    rating: 9
  },
]