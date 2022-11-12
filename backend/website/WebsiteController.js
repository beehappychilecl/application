import express from 'express';

import JsonToolkit from '../toolkit/JsonToolkit.js';
import PropertiesToolkit from '../toolkit/PropertiesToolkit.js';
import RebuildController from '../rebuild/RebuildController.js';
import ScheduleModule from '../schedule/ScheduleModule.js';
import TraceToolkit from '../toolkit/TraceToolkit.js';
import WebsiteModule from '../website/WebsiteModule.js';

class WebsiteController {

    async landing2 () {

        let result = {'fecha': 'hoy mismo probando'};

        let propertiesToolkit = new PropertiesToolkit ()

        let dollar = await propertiesToolkit.get ('scheduler.indicators.dollar');
        let token = await propertiesToolkit.get ('scheduler.indicators.token');

        dollar = dollar + new Date ().getFullYear ().toString ();

        let params = new JsonToolkit ();

        params.add ('apikey', token);
        params.add ('formato', 'json');

        let scheduleModule = new ScheduleModule ();

        await scheduleModule.dollarIndicator (dollar, params)

        return result;

    }

    async awake (request, response) {
    }

    async landing (request, response) {

        console.log (request.headers['user-agent']);

        let traceToolkit = new TraceToolkit ();

        await traceToolkit.initialize ();

        let propertiesToolkit = new PropertiesToolkit ()

        let version = await propertiesToolkit.get ('system.version');

        response.render ('pages/landing/landing.ejs', {'txt_version': version});

        await traceToolkit.finalize ();

    }

    async rebuild (request, response) {

        let traceToolkit = new TraceToolkit ();

        await traceToolkit.initialize ();

        let rebuildController = new RebuildController ();

        await rebuildController.run ();

        console.log ('111');
        response.render ('pages/landing/landing.ejs', {'txt_version': 'rebuild'});
        console.log ('222');

        await traceToolkit.finalize ();

    }

    async staff (request, response) {

        let params = new JsonToolkit ();

        params.add ('txt_first_name', request.params.txt_first_name);

        let websiteModule = new WebsiteModule ();

        let result = await websiteModule.staff (params);
        console.log('********************++');
        console.log(result.outgoing);
        console.log('********************++');

        response.render ('pages/staff/staff.ejs', result.outgoing);

    }

    async vcard (request, response) {

        let params = new JsonToolkit ();

        params.add ('txt_first_name', request.params.txt_first_name);

        let websiteModule = new WebsiteModule ();

        await websiteModule.staff (params);

        let xxx = 'BEGIN:VCARD\n' +
            'VERSION:3.0\n' +
            'N:Alexis;Bacian;;;\n' +
            'FN:Alexis Bacian\n' +
            'TITLE:Director Ejecutivo\n' +
            'ORG:BeeHappy®\n' +
            'TEL;TYPE=WORK,VOICE:56991220195\n' +
            'EMAIL:alexis@beehappy.ee\n' +
            'URL;TYPE=WORK:https://beehappy.ee/staff/alexis\n' +
            'END:VCARD\n';

        response.setHeader ('content-type', 'text/x-vcard');
        response.send (xxx);

    }

}

const router = express.Router ();

let websiteController = new WebsiteController ();

router.get ('/', await websiteController.landing);
router.get ('/staff/:txt_first_name', await websiteController.staff);
router.get ('/staff/:txt_first_name/vcard', await websiteController.vcard);
router.get ('/system/awake', await websiteController.awake);
router.get ('/system/rebuild', await websiteController.rebuild);

export default router;