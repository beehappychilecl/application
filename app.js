import express from 'express';

import {} from './backend/toolkit/constants.js';
import schedule from './backend/schedule/controller.js';

const app = express ();
const port = process.env.PORT || server_port;

app.use (schedule);

app.listen (port, () => {

    console.log (''.concat ('BeeHappyChile started on port: ', port));

});