'user strict';

// Load Dependencies
const express = require('express');
const cors = require('cors');
const superagent = require('superagent');
const pg = require('pg');
const methodOverride = require('method-override');
const indico = require('indico.io');
indico.apiKey = process.env.INDICO_API_KEY;

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
app.post('/', newSuggestion);

//test section
app.get('/test/test', test);
app.get('/test/show', findAir);

//functional
app.get('/login', renderLogin);
app.post('/login', verifyLogin);
app.get('/create', renderCreate);
app.post('/create', createAndLogin);
app.get('/profile/:uid', getProfile);
app.post('/new', newJournal);
app.put('/update', updateJournal);
app.delete('/delete', deleteJournal);
app.get('/logout', logout);

// ============================
// Route handlers
// ============================

function home(req, res) {
  let SQL = `SELECT * FROM suggestions`;

  return client.query(SQL)
    .then(suggestion => {
      let array = suggestion.rows;
      res.render('pages/index', {array});
    })
    .catch(err => handleError(err, res));
}

function test(req, res) {
  res.render('pages/test/test');
}

function renderLogin(req, res) {
  res.render('pages/login/show', {
    onLogin: true
  });
}

function verifyLogin(req, res) {
  const SQL = 'SELECT * FROM users WHERE username=$1;';
  const values = [req.body.username];

  client.query(SQL, values)
    .then(result => {
      if (result.rows.length === 0) {
        res.render('pages/login/show', {
          onLogin: true,
          errorMessage: 'Username does not exist'
        });
      } else {
        const uid = result.rows[0].id;
        const pw = result.rows[0].password;
        if (req.body.password === pw) {
          res.redirect(`/profile/${uid}`);
        } else {
          res.render('pages/login/show', {
            onLogin: true,
            errorMessage: 'Password incorrect'
          });
        }
      }
    })
    .catch(err => handleError(err, res));
}

function renderCreate(req, res) {
  res.render('pages/login/show', {onLogin: false});
}

function createAndLogin (req, res) {
  let SQL = 'SELECT username FROM users';

  client.query(SQL)
    .then(result => {
      if (result.rows.map(n => n.username).includes(req.body.username)) {
        res.render('pages/login/show', {
          onLogin: false,
          errorMessage: 'Username already exists'
        });
      } else {
        SQL = 'INSERT INTO users (username, password) VALUES ($1, $2) RETURNING id;';
        let values = [req.body.username, req.body.password];
        client.query(SQL, values)
          .then(data => {
            res.redirect(`/profile/${data.rows[0].id}`);
          })
          .catch(err => handleError(err, res));
      }
    })
    .catch(err => handleError(err, res));
}

function getProfile(req, res) {
  const SQL = `

  SELECT users.username, journals.*
  FROM users
  LEFT JOIN journals
  ON users.id=journals.uid
  WHERE users.id=$1
  ORDER BY journals.date DESC,
  journals.entered DESC;
  `;

  const values = [req.params.uid];

  client.query(SQL, values)


    .then(result => {
      res.render('pages/profile/show', {
        journals: result.rows[0].id === null ? undefined : result.rows,
        uid: req.params.uid,
        username: result.rows[0].username
      });
    })
    .catch(err => handleError(err, res));
}

function newJournal(req, res) {
  // first indico call returns a high quality assessment
  indico.sentimentHQ(req.body.entry)
    .then(sentiment => {
      // seconen indical returns 5 emotion scores
      indico.emotion(req.body.entry)
        .then(emotions => {
          const journalMetrics = normalizeJournalMetrics(sentiment, emotions);



          const SQL = `INSERT INTO journals(uid, date, exercise, outdoors, entry, sentiment, anger, fear, joy, sadness, surprise) VALUES($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11);`;

          const values = [req.body.uid, req.body.date, req.body.exercise !== undefined, req.body.outdoors !== undefined, req.body.entry, journalMetrics.sentiment, journalMetrics.anger, journalMetrics.fear, journalMetrics.joy, journalMetrics.sadness, journalMetrics.surprise];

          client.query(SQL, values)
            .then(result => {
              res.redirect(`/profile/${req.body.uid}`);
            })
            .catch(err => handleError(err, res));
        })
        .catch(err => handleError(err, res));
    })
    .catch(err => handleError(err, res));
}

function updateJournal(req, res) {
  console.log('got here', req.body);
  indico.sentimentHQ(req.body.entry)
    .then(sentiment => {
      // seconen indical returns 5 emotion scores
      indico.emotion(req.body.entry)
        .then(emotions => {
          const journalMetrics = normalizeJournalMetrics(sentiment, emotions);

          const SQL = `UPDATE journals SET
              date=$2,
              entered=$3,
              exercise=$4,
              outdoors=$5,
              entry=$6,
              sentiment=$7,
              anger=$8,
              fear=$9,
              joy=$10,
              sadness=$11,
              surprise=$12
              WHERE id=$1;`;

          const values = [req.body.jid, req.body.date, new Date().toISOString().slice(0,10), req.body.exercise !== undefined, req.body.outdoors !== undefined, req.body.entry, journalMetrics.sentiment, journalMetrics.anger, journalMetrics.fear, journalMetrics.joy, journalMetrics.sadness, journalMetrics.surprise];

          client.query(SQL, values)
            .then(result => {
              res.redirect(`/profile/${req.body.uid}`);
            })
            .catch(err => handleError(err, res));
        })
        .catch(err => handleError(err, res));
    })
    .catch(err => handleError(err, res));
}

function deleteJournal(req, res) {
  const SQL = 'DELETE FROM journals WHERE id=$1';
  const values = [req.body.jid];

  client.query(SQL, values)
    .then(result => {
      res.redirect(`/profile/${req.body.uid}`);
    })
    .catch(err => handleError(err, res));
}

function newSuggestion(req, res) {
  const SQL = `INSERT INTO suggestions (suggestion, name) VALUES ($1, $2);`;
  const values = [req.body.suggestion, req.body.name];

  console.log('suggestion', req.body);

  return client.query(SQL, values)
    .then(result => {
      console.log('in the then');
      // res.render('pages/index');
      res.redirect('/');
    })
    .catch(err => handleError(err, res));
}

function logout(req, res) {
  res.redirect('/login');
}

// ============================
// Helper functions
// ============================

function normalizeJournalMetrics(sentiment, emotions) {
  emotions.sentiment = sentiment;
  return Object.assign({}, ...Object.keys(emotions).map(e => {
    return {[e]: Math.round(emotions[e] * 10)};
  }));
}
// =============================
// API TEST STUFF
// =============================

function findAir(req, res){
  console.log(req.query)
  return searchLatLong(req.query.search)
    .then( () => {
      res.render('pages/test/show');
    })

    .catch(err => {console.error(err)});
}


// ===============================
//Constructor functions
// ===============================

// function Food(food){
//   this.name = food.fields.item_name;
//   this.brand = food.fields.brand_name;
//   console.log('this', this);
// }

function Location(location){
  this.formatted_query = location.formatted_address;
  this.latitude = location.geometry.location.lat;
  this.longitude = location.geometry.location.lng;
}

//Search for Resource
// function foodSearch(query){
//   console.log('in my query function', query);
//   let url = `https://api.nutritionix.com/v1_1/search/${query}?appId=d1c767cf&appKey=${process.env.NUTRITIONIX_API_KEY}`;
//   console.log('searching');
//   return superagent.get(url)
//     .then(foodData => {
//       let results = foodData.body.hits.map(item => new Food(item));
//       res.render('/pages/test/show', {results});
//     })
//     .catch(err => console.error(err));
// }

function searchLatLong(query){
  console.log('query', query);
  const url = `https://maps.googleapis.com/maps/api/geocode/json?address=${query}&key=${process.env.GEOCODE_API_KEY}`;
  return superagent.get(url)
    .then(geoData => {
      const location = new Location(geoData.body.results[0]);
      console.log('location', location);

      return location;
    })
    .catch(err =>console.error(err));
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
