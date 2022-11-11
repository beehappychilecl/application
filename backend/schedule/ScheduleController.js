import express from 'express';
import nodeCron from 'node-cron';

import JsonToolkit from '../toolkit/JsonToolkit.js';
import PropertiesToolkit from '../toolkit/PropertiesToolkit.js'
import ScheduleModule from '../schedule/ScheduleModule.js';

class ScheduleController {

    async awake () {

        let propertiesToolkit = new PropertiesToolkit ()

        let host = await propertiesToolkit.get ('scheduler.awake.host');

        let scheduleModule = new ScheduleModule ();

        await scheduleModule.uptime (host);

        console.log ('Running wakeup task every 10 minutes');

        return null;

    }

    async indicators () {

        let propertiesToolkit = new PropertiesToolkit ()

        let dollar = await propertiesToolkit.get ('scheduler.indicators.dollar');
        let euro = await propertiesToolkit.get ('scheduler.indicators.euro');
        let foment_unit = await propertiesToolkit.get ('scheduler.indicators.foment_unit');
        let monthly_tax_unit = await propertiesToolkit.get ('scheduler.indicators.monthly_tax_unit');
        let token = await propertiesToolkit.get ('scheduler.indicators.token');

        dollar = dollar + new Date ().getFullYear ().toString ();
        euro = euro + new Date ().getFullYear ().toString ();
        foment_unit = foment_unit + new Date ().getFullYear ().toString ();
        monthly_tax_unit = monthly_tax_unit + new Date ().getFullYear ().toString ();

        let params = new JsonToolkit ();

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

        let propertiesToolkit = new PropertiesToolkit ()

        let awake = await propertiesToolkit.get ('scheduler.awake.cron');
        let indicators = await propertiesToolkit.get ('scheduler.indicators.cron');

        nodeCron.schedule (awake, await this.awake);
        nodeCron.schedule (indicators, await this.indicators);

    }

}

const router = express.Router ();

let scheduleController = new ScheduleController ();

await scheduleController.run ();

export default router;