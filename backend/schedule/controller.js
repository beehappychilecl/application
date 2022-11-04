import nodeCron from 'node-cron';
import constants from '../toolkit/constants.js';
import module from '../schedule/module.js';

async function indicators () {

    let result = module.indicators ();

    console.log (result);
    console.log ('Running indicators task any times per day');

}

async function uptime () {

    let result = await module.uptime ();

    console.log (result);
    console.log ('Running wakeup task every 10 minutes');

}

nodeCron.schedule (constants.scheduler_indicators, indicators);

nodeCron.schedule (constants.scheduler_uptime, uptime);