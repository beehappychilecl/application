import nodeCron from 'node-cron';
import constants from '../toolkit/constants.js';
import module from './module.js';

async function indicators () {

    const result = module.indicators (null, null);

    console.log ('Running indicators task any times per day');

}

async function wakeup () {

    let result = module.wakeup (null, null);

    console.log ('Running wakeup task every 10 minutes');

}

nodeCron.schedule (constants.scheduler_indicators, indicators);

nodeCron.schedule (constants.scheduler_wakeup, wakeup);