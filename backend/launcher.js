import cors from 'cors';
import ejs from 'ejs';
import express from 'express';

import constants from './toolkit/constants.js';
import schedule from './schedule/controller.js';
import system from './system/controller.js';
import views from './views/controller.js';

const app = express ();

app.set ('view engine', ejs);
app.use (cors ());
app.use (express.json ())
app.use (express.static ('frontend'));
app.use (express.urlencoded ({extended: true}));

app.use (schedule);
app.use (system);
app.use (views);

const port = process.env.PORT || constants.server_port;

app.listen (port, () => {

    console.log (''.concat ('BeeHappy Chile started on port: ', port));

});