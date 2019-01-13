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
app.get('/test/test', test);
app.post('/test/test', test);
app.post('/test/show', foodSearch);
app.get('/login', login);
app.post('/create', createUser);
app.get('/profile', getProfile);
app.post('/new', newJournal);



// Route handlers
function home(req, res) {
  res.render('pages/index');
}

function test(req, res) {
  res.render('pages/test/test');
}

function login(req, res) {
  res.render('pages/login/show');
}

function createUser(req, res) {
  res.render('pages/login/new');
}

function getProfile(req, res) {
  res.render('pages/profile/show', {journals: journals});
}

function newJournal(req, res) {
  // TODO
}

//Constructor functions
function Food(food){
  this.name = food.fields.item_name;
  this.brand = food.fields.brand_name;
}

//Search for Resource
function foodSearch(query){
  const url = `https://api.nutritionix.com/v1_1/search/black-beans?appId=d1c767cf&appKey=${process.env.NUTRITIONIX_API_KEY}`;
  return superagent.get(url)
    .then(foodData => {
      const results = foodData.hits.map(item => {
        console.log('in the .map');
        let food = new Food(item);
        console.log(food);
        res.render('/pages/test/test', {food});
      })
    })
    .catch(err => console.error(err));
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
    entry: 'Consectetur dolorum aliquam, totam vero odit sit quasi consequatur aspernatur corporis tempora rerum autem. Aliquid itaque enim quibusdam repellat consectetur totam consequuntur. Had a wonderful time with the family on the lake.',
    rating: 3
  },
  {
    id: 2,
    uid: 12,
    date: new Date(2019, 01, 01),
    exercise: true,
    outdoors: true,
    entry: 'Felt kind of hungover. Lorem ipsum dolor sit amet consectetur adipisicing elit. Consectetur dolorum aliquam, totam vero odit sit quasi consequatur aspernatur corporis tempora rerum autem. Aliquid itaque enim quibusdam repellat consectetur totam consequuntur.',
    rating: 4
  },
  {
    id: 3,
    uid: 12,
    date: new Date(2019, 01, 09),
    exercise: false,
    outdoors: false,
    entry: 'Played computer games until my eyes bled. Lorem ipsum dolor sit amet consectetur adipisicing elit. ',
    rating: 9
  },
]