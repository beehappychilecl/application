import express from "express";
import nodeCron from 'node-cron';

import constants from '../toolkit/constants.js';
import module from '../schedule/module.js';

const router = express.Router ();

const indicators = async () => {

    await module.indicators ();

    console.log ('Running indicators task any times per day');

}

const uptime = async () => {

    await module.uptime ();

    console.log ('Running wakeup task every 10 minutes');

}

nodeCron.schedule (constants.scheduler_indicators, indicators);
nodeCron.schedule (constants.scheduler_uptime, uptime);

export default router;