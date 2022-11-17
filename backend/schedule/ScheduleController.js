import express from 'express';
import nodeCron from 'node-cron';

import JsonTool from '../toolkit/JsonTool.js';
import LogTool from "../toolkit/LogTool.js";
import PropertiesTool from '../toolkit/PropertiesTool.js'
import ScheduleModule from '../schedule/ScheduleModule.js';
import ResponseTool from "../toolkit/ResponseTool.js";

class ScheduleController {

    async awake () {

        let logTool = new LogTool ('ScheduleController', 'awake', null);

        await logTool.initialize ();

        let propertiesTool = new PropertiesTool ()

        let host = await propertiesTool.get ('scheduler.awake.host');

        let scheduleModule = new ScheduleModule ();

        await scheduleModule.awake (logTool.traceTool, host);

        let result = ResponseTool.SUCCESSFUL ();

        await logTool.realize (result);
        await logTool.finalize ('Running awake task every ten minutes');

    }

    async indicators () {

        let logTool = new LogTool ('ScheduleController', 'indicators', null);

        await logTool.initialize ();

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

        await scheduleModule.dollarIndicator (logTool.traceTool, dollar, params)
        await scheduleModule.euroIndicators (logTool.traceTool, euro, params);
        await scheduleModule.fomentUnitIndicators (logTool.traceTool, foment_unit, params);
        await scheduleModule.monthlyTaxUnitIndicators (logTool.traceTool, monthly_tax_unit, params);

        let result = ResponseTool.SUCCESSFUL ();

        await logTool.realize (result);
        await logTool.finalize ('Running indicators task any times per day');

    }

    async run () {

        let logTool = new LogTool ('ScheduleController', 'run', null);

        await logTool.initialize ();

        let propertiesTool = new PropertiesTool ()

        let awake = await propertiesTool.get ('scheduler.awake.cron');
        let indicators = await propertiesTool.get ('scheduler.indicators.cron');

        nodeCron.schedule (awake, await this.awake);
        nodeCron.schedule (indicators, await this.indicators);

        let result = ResponseTool.SUCCESSFUL ();

        await logTool.realize (result);
        await logTool.finalize ();

    }

}

const router = express.Router ();

let scheduleController = new ScheduleController ();

await scheduleController.run ();

export default router;