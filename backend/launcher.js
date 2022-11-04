import express from 'express';
import constants from './toolkit/constants.js';
import './schedule/controller.js';
import system from './system/controller.js';

const app = express ();
const port = process.env.PORT || constants.server_port;

app.use (express.static ('frontend'))
app.use (system);

app.listen (port, () => {

    console.log (''.concat ('BeeHappy Chile started on port: ', port));

});