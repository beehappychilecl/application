import express from 'express';
import nodeCron from 'node-cron';

const router = express.Router ();

const indicators = nodeCron.schedule (scheduler_indicators, () => {

    console.log ('Running indicators task many times per day');

});

const wakeup = nodeCron.schedule (scheduler_wakeup, () => {

    console.log ('Running wakeup task every 10 minutes');

});

indicators.start ();
wakeup.start ();

export default router;