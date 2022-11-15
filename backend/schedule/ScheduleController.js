import express from 'express';
import nodeCron from 'node-cron';

import JsonTool from '../toolkit/JsonTool.js';
import PropertiesTool from '../toolkit/PropertiesTool.js'
import ScheduleModule from '../schedule/ScheduleModule.js';
import LogTool from "../toolkit/LogTool.js";

class ScheduleController {

    async awake () {

        let traceTool = new LogTool ();

        await traceTool.initialize ();

        let propertiesTool = new PropertiesTool ()

        let host = await propertiesTool.get ('scheduler.awake.host');

        let scheduleModule = new ScheduleModule ();

        await scheduleModule.uptime (host);

        console.log ('Running wakeup task every 10 minutes');

        return null;

    }

    async indicators () {

        let traceTool = new LogTool ();

        await traceTool.initialize ();

        let propertiesTool = new PropertiesTool ()

        let dollar = await propertiesTool.get ('scheduler.indicators.dollar');
        let euro = await propertiesTool.get ('scheduler.indicators.euro');
        let foment_unit = await propertiesTool.get ('scheduler.indicators.foment_unit');
        let monthly_tax_unit = await propertiesTool.get ('scheduler.indicators.monthly_tax_unit');
        let token = await propertiesTool.get ('scheduler.indicators.token');

        dollar = dollar + new Date ().getFullYear ().toString ();
        euro = euro + new Date ().getFullYear ().toString ();
        foment_unit = foment_unit + new Date ().getFullYear ().toString ();
        monthly_tax_unit = monthly_tax_unit + new Date ().getFullYear ().toString ();

        let params = new JsonTool ();

        params.add ('apikey', token);
        params.add ('formato', 'json');

        let scheduleModule = new ScheduleModule ();

        await scheduleModule.dollarIndicator (dollar, params)
        await scheduleModule.euroIndicators (euro, params);
        await scheduleModule.fomentUnitIndicators (foment_unit, params);
        await scheduleModule.monthlyTaxUnitIndicators (monthly_tax_unit, params);

        console.log ('Running indicators task any times per day');

        return null;

    }

    async run () {

        let propertiesTool = new PropertiesTool ()

        let awake = await propertiesTool.get ('scheduler.awake.cron');
        let indicators = await propertiesTool.get ('scheduler.indicators.cron');

        nodeCron.schedule (awake, await this.awake);
        nodeCron.schedule (indicators, await this.indicators);

    }

}

const router = express.Router ();

let scheduleController = new ScheduleController ();

await scheduleController.run ();

export default router;